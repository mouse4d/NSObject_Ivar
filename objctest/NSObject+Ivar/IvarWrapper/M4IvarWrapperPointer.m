//
//  Mp4IvarWrapperPointer.m
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

#import "M4IvarWrapperPointer.h"
#import "M4IvarWrapperFactory.h"

@implementation M4IvarWrapperPointer{

    M4IvarWrapperAbstract *_itemsWrapper;
}

- (id)initWithIvar:(Ivar)ivar factory:(M4IvarWrapperFactory *)factory {

    self = [super initWithIvar:ivar factory:factory];
    if (self) {

        const char *encoding = ivar_getTypeEncoding(ivar);
        [self setupWithEcoding:[NSString stringWithUTF8String:encoding]];
    }
    return self;
}


- (id)initWithEncoding:(NSString *)encoding factory:(M4IvarWrapperFactory *)factory {

    self = [super initWithEncoding:encoding factory:factory];
    if (self) {

        [self setupWithEcoding:encoding];
    }
    return self;
}


- (void)setupWithEcoding:(NSString*)encoding {

    encoding = [encoding substringWithRange:NSMakeRange(1, encoding.length - 1)];
    _itemsWrapper = [self.ivarFactory wrapperWithEncoding:encoding];
}


- (NSUInteger)encodingLength {

    return _itemsWrapper.encodingLength + 1;
}


- (size_t)size {

    return sizeof(void*); // doesn't matter where and to what type it points, a pointer is a pointer, 
}


- (NSString*)stringType {

    return [NSString stringWithFormat:@"(%@)*", _itemsWrapper.stringType];
}


- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }
    return [_itemsWrapper stringValueWithPointer:*(void**)pointer];
}


- (NSString*)stringValueWithObject:(id)object {

    void *pointer = ((void* (*)(id, Ivar))object_getIvar)(object, self.ivar);

    return [self stringValueWithPointer:&pointer];
}

@end
