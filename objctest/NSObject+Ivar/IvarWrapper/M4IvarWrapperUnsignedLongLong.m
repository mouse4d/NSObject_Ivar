//
//  M4IvarWrapperUnsignedLongLong.m
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

#import "M4IvarWrapperUnsignedLongLong.h"

@implementation M4IvarWrapperUnsignedLongLong


- (size_t)size {

    return sizeof(unsigned long long);
}


- (NSString*)stringType {

    return @"unsigned long long";
}


- (NSString*)stringValueWithObject:(id)object {

    return [NSString stringWithFormat:@"%llu", ((unsigned long long (*)(id, Ivar))object_getIvar)(object, self.ivar)];
}


- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }

    return [NSString stringWithFormat:@"%llu", *(unsigned long long*)pointer];
}

@end
