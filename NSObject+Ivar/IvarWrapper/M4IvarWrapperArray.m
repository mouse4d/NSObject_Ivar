//
//  M4IvarWrapperArray.m
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

#import "M4IvarWrapperArray.h"
#import "M4IvarWrapperFactory.h"

@implementation M4IvarWrapperArray {

    NSUInteger _count;
    NSUInteger _digitsInCountNr;
    NSString    *_stringType;
    M4IvarWrapperAbstract *_itemsWrapper;
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


    NSUInteger index = 1;
    _count = 0;
    _digitsInCountNr = 0;

    const char *encodingCharString = [encoding UTF8String];

    // search the index of the last digit
    while (encodingCharString[index] >= '0'
           && encodingCharString[index] <= '9') {

        _count *= 10;
        _count += encodingCharString[index] - 0x30; //make it a real digit, fast and dirty
        _digitsInCountNr++;
        
        index++;
    }

    // TODO: add processing of the array items
    _stringType = [encoding substringWithRange:NSMakeRange(index, encoding.length - 1 - index)];

    _itemsWrapper = [self.ivarFactory wrapperWithEncoding:_stringType];
}


- (NSUInteger)encodingLength {

    return 2 + _digitsInCountNr + _itemsWrapper.encodingLength;
}


- (size_t)size {

    return _count * _itemsWrapper.size;
}


- (NSString*)stringType {

    return [NSString stringWithFormat:@"(%@)[%d]", _itemsWrapper.stringType, _count];
}


- (NSString*)stringValueWithObject:(id)object {


    void *p = (void*)((__bridge void*)object + ivar_getOffset(self.ivar));

    return [self stringValueWithPointer:p];
}



- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }

    NSMutableString *stringValue = [[NSMutableString alloc] init];
    [stringValue appendString:@"["];

    for (int i = 0; i < _count; i++) {

        [stringValue appendFormat:@"\n%@", [_itemsWrapper stringValueWithPointer:pointer]];
        pointer += _itemsWrapper.size;
    }
    [stringValue appendString:@"\n]"];

    return stringValue;
}





@end
