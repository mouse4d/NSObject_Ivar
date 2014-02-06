//
//  M4IvarWrapperBoolean.m
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

#import "M4IvarWrapperBoolean.h"

@implementation M4IvarWrapperBoolean


- (size_t)size {

    return sizeof(bool);
}


- (NSString*)stringType {

    return @"bool";
}


- (NSString*)stringValueWithObject:(id)object {

    BOOL var = ((bool (*)(id, Ivar))object_getIvar)(object, self.ivar);

    if (var) {
        return @"YES";
    } else {
        return @"NO";
    }
}


- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }

    BOOL var = *(bool*)pointer;

    if (var) {
        return @"YES";
    } else {
        return @"NO";
    }
}

@end
