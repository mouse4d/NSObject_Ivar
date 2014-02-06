//
//  ObjectWithPrimitiveValues.m
//  objctest
//
//  Created by Leonid Popescu on 06/02/2014.
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

#import "ObjectWithPrimitiveValues.h"

@implementation ObjectWithPrimitiveValues {

    char                _aChar;
    BOOL                _aBool;
    short               _aShort;
    int                 _anInt;
    long                _aLong;
    long long           _aLongLong;

    unsigned int        _anUnsignedInt;
    unsigned char       _anUnsignedChar;
    unsigned long       _anUnsignedLong;
    unsigned long long _anUnsignedLongLong;
    unsigned short      _anUnsignedShort;

    double              _aDouble;
    float               _aFloat;

    char*               _aCharString;
    Class               _aClass;
    id                  _anObject;
    SEL                 _aSelector;

}


+ (instancetype)obj {

    return [[self alloc] init];
}


- (id)init
{
    self = [super init];
    if (self) {

        _aChar = 'a';
        _aBool = YES;
        _aShort = -35;
        _anInt = -32000;
        _aLong = -2000000;
        _aLongLong = -9000000;
        _anUnsignedInt = 60000;
        _anUnsignedChar = 254;
        _anUnsignedLong = 2000000;
        _anUnsignedLongLong = 9000000;

        _aDouble = 1234e-89;
        _aFloat = 67e34;

        _aCharString = "this is a message \n read it carefully and";
        _aClass = [NSString class];
        _anObject = self;
        _aSelector = @selector(initByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:);
    }
    return self;
}

@end
