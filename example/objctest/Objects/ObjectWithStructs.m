//
//  ObjectWithStructs.m
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

#import "ObjectWithStructs.h"

@implementation ObjectWithStructs

+ (instancetype)obj {

    return [[self alloc] init];
}


- (id)init {

    self = [super init];
    if (self) {

        _aStruct.anInt = 3;
        _aPointerToStruct = &_aStruct;

        _structWithNestedStruct.l1 = 15.3;
        _structWithNestedStruct.sl1.anInt= 15;
        _pointerToStructWithNestedStruct = &_structWithNestedStruct;

        _structLvl2.l2 = 18.1;
        _structLvl2.sl2.l1 = 16.1;
        _structLvl2.sl2.sl1.anInt = 15;
        _pointerToStructLvl2 = &_structLvl2;

        _pointerStruct.i = &(_aStruct.anInt);
        _pointerStruct.lv2 = _pointerToStructLvl2;
        _pointerToPointerStruct = &_pointerStruct;

        _pointerStructWithNULLPointers.i = NULL;
        _pointerStructWithNULLPointers.lv2 = NULL;
        _pointerToPointerStructWithNULLPointers = &_pointerStructWithNULLPointers;
    }
    return self;
}

@end
