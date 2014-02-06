//
//  ObjectWithArrays.m
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

#import "ObjectWithArrays.h"

@implementation ObjectWithArrays {

    int arrayOfInts[4];
    int* arrayOfPointersToInts[4];
    int (*pointerToArrayOfInts)[4];
    int *(*pointerToArrayofPointersToInts)[4];

    float *arrayOfNULLFloats[2];
}


+ (instancetype)obj {

    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        arrayOfInts[0] = 100;
        arrayOfInts[1] = 200;
        arrayOfInts[2] = 300;
        arrayOfInts[3] = 400;

        arrayOfPointersToInts[0] = &arrayOfInts[0];
        arrayOfPointersToInts[1] = &arrayOfInts[1];
        arrayOfPointersToInts[2] = &arrayOfInts[2];
        arrayOfPointersToInts[3] = &arrayOfInts[3];

        pointerToArrayOfInts = &arrayOfInts;
        pointerToArrayofPointersToInts = &arrayOfPointersToInts;

        arrayOfNULLFloats[0] = NULL;
        arrayOfNULLFloats[1] = NULL;

    }
    return self;
}

@end
