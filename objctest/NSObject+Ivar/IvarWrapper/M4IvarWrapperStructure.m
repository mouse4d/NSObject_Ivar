//
//  M4IvarWrapperStructure.m
//  objctest
//
//  Created by Leonid Popescu on 04/02/2014.
//  Copyright (c) 2014 becauseTuesday. All rights reserved.
//
/*
	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "M4IvarWrapperStructure.h"
#import "M4IvarWrapperFactory.h"

@implementation M4IvarWrapperStructure {

    NSArray     *_ivarWrappers;
    NSString    *_stringType;
    NSUInteger  _encodingLength;
    size_t      _size;
}


- (id)initWithIvar:(Ivar)ivar factory:(M4IvarWrapperFactory *)factory {

    self = [super initWithIvar:ivar factory:factory];
    if (self) {

        const char *encoding = ivar_getTypeEncoding(ivar);
        [self setupWithEncoding:[NSString stringWithUTF8String:encoding]];
    }
    return self;
}


- (id)initWithEncoding:(NSString *)encoding factory:(M4IvarWrapperFactory *)factory {

    self = [super initWithEncoding:encoding factory:factory];
    if (self) {

        [self setupWithEncoding:encoding];
    }
    return self;
}


- (void)setupWithEncoding:(NSString*)encoding {

    encoding = [self encodingWithoutJunkFromEncoding:encoding];

    _encodingLength = encoding.length+2; // +2 for the brackets

    // the encoding can have the following formats:
    // {StructTag}      - when it's level of indirection is 2 and above, aka pointer to pointer to struct, ex: struct StructTag **var;
    // {StructTag=@*i}  - when it's indirected via a pointer, ex: struct StructTag *var;
    // {StructTag="anObj"@"anCharString"*"anInt"i} - when the struct is the variable, ex: StructTag var;


    // determine the level of indirection and act accordingly
    // principle of detection:
    // has quotes - level 0
    // doesn't hae quotes but contains the '=' - leve 1
    // no quotes and no '=' - level 2+

    // this seems to be faster, but also the strings are mostly really short, so I didn't bother with
    // mega optimisations


    NSRange equalSignRange = [encoding rangeOfString:@"="];

    if (equalSignRange.location == NSNotFound) { //if no equal sign - level 2+ of indirectio

        _stringType = encoding;
        _size = 0;

    } else {

        _stringType = [encoding substringToIndex:equalSignRange.location];

        // the string with only the items, ex '@if' when indirected, '"anOj"@"anint"i"anFloat"f' - when not inderected
        NSString *itemsEncoding = [encoding substringWithRange:NSMakeRange(equalSignRange.location+1, encoding.length-equalSignRange.location-1)];

        _ivarWrappers = [self ivarWrappersFromItemsEncoding:itemsEncoding];

        for (M4IvarWrapperAbstract *ivarWrapper in _ivarWrappers) {
            _size += ivarWrapper.size;
        }
    }
}



- (size_t)size {

    return _size;
}


- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }


    NSMutableString *stringValue = [[NSMutableString alloc] init];
    [stringValue appendString:@"{"];


    if (pointer == nil) {
        [stringValue appendString:@"nil"];
    } else {

        // this approach is required because of reasons. I don't know them, but it's the only way I could make  it work
        void *var = (pointer + ivar_getOffset(self.ivar));
        for (M4IvarWrapperAbstract *ivarWrapper in _ivarWrappers) {

            if (ivarWrapper.name.length == 0) {
                ivarWrapper.name = @"?";
            }

            [stringValue appendFormat:@"\n%@ %@ = %@", ivarWrapper.stringType, ivarWrapper.name, [ivarWrapper stringValueWithPointer:var]];
            var += ivarWrapper.size;
        }
        [stringValue appendString:@"\n"];
    }

    [stringValue appendString:@"}"];
    
    return stringValue;
}



- (NSString *)stringValueWithObject:(id)object {

    return [self stringValueWithPointer:(__bridge void*)object];
}



- (NSString *)stringType {

    return _stringType;
}


- (NSUInteger)encodingLength {

    return _encodingLength;
}


#pragma mark - internal

/**
 if there are more ivars in this encoding (think nested structs), extract only the encoding
 of this struct whithout the brackets
 this will be done in the following way: add one for an open bracket, remove one for a closed
 one, when the unclosed bracketCount is again zero, then we achieved the end of this struct
 */
- (NSString*)encodingWithoutJunkFromEncoding:(NSString*)encoding {

    NSUInteger bracketCount = 0;
    NSUInteger index = -1;

    do {

        unichar theChar = [encoding characterAtIndex:++index];

        if  (theChar == '}') {
            bracketCount--;

        } else if (theChar == '{') {
            bracketCount++;
        }

    } while (bracketCount!=0);

    return [encoding substringWithRange:NSMakeRange(1, index-1)];
}


- (NSArray*)ivarWrappersFromItemsEncoding:(NSString*)itemsEncoding {

    NSMutableArray *ivarWrappers = [[NSMutableArray alloc] init];

    while (itemsEncoding.length > 0) {

        //remove the name when we have the case "varName"i"somePointerName"^f

        NSString *itemName = [self firstItemNameEncoding:itemsEncoding];
        if (itemName.length > 0) {
            itemsEncoding = [itemsEncoding substringFromIndex:itemName.length+2]; //+2 for the quotes
        }

        M4IvarWrapperAbstract *ivarWrapper = [self.ivarFactory wrapperWithEncoding:itemsEncoding];
        ivarWrapper.name = itemName;
        [ivarWrappers addObject:ivarWrapper];
        itemsEncoding = [itemsEncoding substringFromIndex:ivarWrapper.encodingLength];
    }

    return ivarWrappers;
}



- (NSString*)firstItemNameEncoding:(NSString*)encoding {

    NSString *itemName = nil;

    if ([encoding characterAtIndex:0] == '"') {


        NSRange rangeOfTheSecondQuote = [encoding rangeOfString:@"\""
                                                        options:0
                                                          range:NSMakeRange(1, encoding.length-1)];

        itemName = [encoding substringWithRange:NSMakeRange(1, rangeOfTheSecondQuote.location-1)];
    }

    return itemName;

}

@end
