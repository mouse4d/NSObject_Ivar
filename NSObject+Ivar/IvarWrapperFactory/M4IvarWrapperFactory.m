//
//  M4IvarWrapperFactory.m
//  objctest
//
//  Created by Leonid Popescu on 05/02/2014.
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

#import "M4IvarWrapperFactory.h"

#import "M4IvarWrapperAbstract.h"

#import "M4IvarWrapperChar.h"
#import "M4IvarWrapperInt.h"
#import "M4IvarWrapperShort.h"
#import "M4IvarWrapperLong.h"
#import "M4IvarWrapperLongLong.h"
#import "M4IvarWrapperUnsignedChar.h"
#import "M4IvarWrapperUnsignedInt.h"
#import "M4IvarWrapperUnsignedShort.h"
#import "M4IvarWrapperUnsignedLong.h"
#import "M4IvarWrapperUnsignedLongLong.h"
#import "M4IvarWrapperFloat.h"
#import "M4IvarWrapperDouble.h"
#import "M4IvarWrapperBoolean.h"
#import "M4IvarWrapperVoid.h"
#import "M4IvarWrapperCharString.h"
#import "M4IvarWrapperObject.h"
#import "M4IvarWrapperClass.h"
#import "M4IvarWrapperSelector.h"
#import "M4IvarWrapperArray.h"
#import "M4IvarWrapperPointer.h"
#import "M4IvarWrapperUnkown.h"
#import "M4IvarWrapperStructure.h"

@implementation M4IvarWrapperFactory



- (M4IvarWrapperAbstract*)wrapperWithIvar:(Ivar)ivar {

    const char *typeEncoding = ivar_getTypeEncoding(ivar);

    Class clazz = [self wrapperClassForEncodeChar:*typeEncoding];
    M4IvarWrapperAbstract *ivarWrapper = [[clazz alloc] initWithIvar:ivar factory:self];
    ivarWrapper.ivarFactory = self;

    return ivarWrapper;
}


- (M4IvarWrapperAbstract*)wrapperWithEncoding:(NSString *)encoding {

    Class clazz = [self wrapperClassForEncodeChar:[encoding characterAtIndex:0]];
    M4IvarWrapperAbstract *ivarWrapper = [[clazz alloc] initWithEncoding:encoding factory:self];
    ivarWrapper.ivarFactory = self;

    return ivarWrapper;
}



- (Class)wrapperClassForEncodeChar:(char)encodeChar {


    static NSDictionary *_map = nil;

    if (_map == nil) {

        _map = @{@'c'  : M4IvarWrapperChar.class,
                  @'i' : M4IvarWrapperInt.class,
                  @'s' : M4IvarWrapperShort.class,
                  @'l' : M4IvarWrapperLong.class,
                  @'q' : M4IvarWrapperLongLong.class,
                  @'C' : M4IvarWrapperUnsignedChar.class,
                  @'I' : M4IvarWrapperUnsignedInt.class,
                  @'S' : M4IvarWrapperUnsignedShort.class,
                  @'L' : M4IvarWrapperUnsignedLong.class,
                  @'Q' : M4IvarWrapperUnsignedLongLong.class,
                  @'f' : M4IvarWrapperFloat.class,
                  @'d' : M4IvarWrapperDouble.class,
                  @'B' : M4IvarWrapperBoolean.class,
                  @'v' : M4IvarWrapperVoid.class,
                  @'*' : M4IvarWrapperCharString.class,
                  @'@' : M4IvarWrapperObject.class,
                  @'#' : M4IvarWrapperClass.class,
                  @':' : M4IvarWrapperSelector.class,
                  @'[' : M4IvarWrapperArray.class,
                  @'^' : M4IvarWrapperPointer.class,
                  @'{' : M4IvarWrapperStructure.class};
    }

    Class clazz = _map[[NSNumber numberWithChar:encodeChar]];

    if (clazz == nil) {
        clazz = M4IvarWrapperUnkown.class;
    }
    
    return clazz;
}



@end
