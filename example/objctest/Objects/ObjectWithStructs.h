//
//  ObjectWithStructs.h
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

#import <Foundation/Foundation.h>



typedef struct StructTag {
    int anInt;
}structtype;


typedef struct level1Tag {
    float l1;
    structtype sl1;
} level1;


typedef struct level2Tag {

    double l2;
    level1 sl2;
} level2;


typedef struct PointerStructTag {

    int *i;
    level2 *lv2;
}PointerStruct;





@interface ObjectWithStructs : NSObject

@property (nonatomic, assign) structtype aStruct;
@property (nonatomic, assign) structtype *aPointerToStruct;

@property (nonatomic, assign) level1 structWithNestedStruct;
@property (nonatomic, assign) level1 *pointerToStructWithNestedStruct;

@property (nonatomic, assign) level2 structLvl2;
@property (nonatomic, assign) level2 *pointerToStructLvl2;


@property (nonatomic, assign) PointerStruct pointerStruct;
@property (nonatomic, assign) PointerStruct *pointerToPointerStruct;

@property (nonatomic, assign) PointerStruct pointerStructWithNULLPointers;
@property (nonatomic, assign) PointerStruct *pointerToPointerStructWithNULLPointers;

+ (instancetype)obj;


@end
