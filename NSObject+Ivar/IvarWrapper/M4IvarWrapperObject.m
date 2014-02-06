//
//  M4IvarWrapperObject.m
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

#import "M4IvarWrapperObject.h"

@implementation M4IvarWrapperObject


- (size_t)size {

    return sizeof(id);
}


- (NSString*)stringType {

    return @"id";
}


- (NSString*)stringValueWithObject:(id)object {

    return [NSString stringWithFormat:@"%@", ((id (*)(id, Ivar))object_getIvar)(object, self.ivar)];
}


- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }

    __weak id object = *(__weak id*)pointer;

    return [object description];
}


@end
