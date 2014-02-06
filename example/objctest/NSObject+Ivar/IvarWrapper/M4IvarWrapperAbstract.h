//
//  M4IvarWrapperAbstract.h
//  objctest
//
//  Created by Leonid Popescu on 03/02/2014.
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
#import <objc/runtime.h>

@class M4IvarWrapperFactory;
@interface M4IvarWrapperAbstract : NSObject

@property (readonly, assign, nonatomic) Ivar ivar;
@property (copy,  nonatomic) NSString *name;

- (size_t)size;
- (NSString*)stringType;
- (NSString*)stringValueWithObject:(id)object;
- (NSString*)stringValueWithPointer:(void*)pointer;


- (id)initWithIvar:(Ivar)ivar factory:(M4IvarWrapperFactory*)factory;
- (id)initWithEncoding:(NSString*)encoding factory:(M4IvarWrapperFactory*)factory;


/// for internal use
- (NSUInteger)encodingLength;
@property (strong, nonatomic) M4IvarWrapperFactory *ivarFactory;

@end
