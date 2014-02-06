//
//  M4IvarWrapperAbstract.m
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

#import "M4IvarWrapperAbstract.h"


@implementation M4IvarWrapperAbstract 



- (id)initWithIvar:(Ivar)ivar factory:(M4IvarWrapperFactory *)factory {

    self = [super init];
    if (self) {

        _ivar = ivar;
        const char *ivarName = ivar_getName(ivar);
        // TODO: check if it's really copied
        _name = [NSString stringWithUTF8String:ivarName];
        _ivarFactory = factory;
    }
    return self;
}


- (id)initWithEncoding:(NSString *)encoding factory:(M4IvarWrapperFactory *)factory {

    self = [super init];
    if (self) {

        _ivar = nil;
        _name = nil;
        _ivarFactory = factory;
    }
    return self;
}



- (size_t)size {
    return 0;
}


- (NSString*)stringValueWithPointer:(void *)pointer {
    return @" !!! not implemented !!! ";
}

- (NSString*)stringValueWithObject:(id)object {
    return @" !!! not implemented !!! ";
}

- (NSString *)stringType {
    return @" !!! not implemented !!! ";
}

// the length of its encoding string
- (NSUInteger)encodingLength {
    return 1;
}

@end
