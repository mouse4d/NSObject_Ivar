//
//  M4IvarWrapperFloat.m
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

#import "M4IvarWrapperFloat.h"

@implementation M4IvarWrapperFloat

- (size_t)size {

    return sizeof(float);
}


- (NSString*)stringType {

    return @"float";
}


- (NSString*)stringValueWithObject:(id)object {

    // this approach is required because of reasons. I don't know them, but it's the only way I could make  it work
    float var = *(float*)((__bridge void*)object + ivar_getOffset(self.ivar));
    return [NSString stringWithFormat:@"%e", var];
}


- (NSString *)stringValueWithPointer:(void *)pointer {

    if (pointer==nil) {
        return @"NULL";
    }

    return [NSString stringWithFormat:@"%e", *(float*)pointer];
}

@end
