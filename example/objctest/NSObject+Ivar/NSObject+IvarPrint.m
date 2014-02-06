//
//  NSObject+PrettyPrint.m
//  objctest
//
//  Created by Leonid Popescu on 31/01/2014.
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

#import "NSObject+IvarPrint.h"
#import <objc/objc.h>
#import <objc/runtime.h>

#import "M4IvarWrapperAbstract.h"
#import "M4IvarWrapperFactory.h"

@implementation NSObject (IvarPrint)

- (NSString *)ivarDescriptions {

    NSMutableString *ivarDescriptions = [[NSMutableString alloc] init];

    [ivarDescriptions appendString:NSStringFromClass(self.class)];
    [ivarDescriptions appendString:@" {"];


    NSArray *ivars = [self ivarWrappers];

    for (M4IvarWrapperAbstract *ivarWrapper in ivars) {

        [ivarDescriptions appendFormat:@"\n%@ %@ = %@", ivarWrapper.stringType, ivarWrapper.name, [ivarWrapper stringValueWithObject:self]];
    }

    [ivarDescriptions appendFormat:@"\n}"];
    
    return [self prettyStringFromDescription:ivarDescriptions];
}



- (NSArray*)ivarNames {

    NSMutableArray *ivarNames= nil;

    //get the list of internal variables
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &ivarsCount);

    if (ivarsCount > 0) {

        ivarNames = [[NSMutableArray alloc] initWithCapacity:ivarsCount];

        for (int i = 0; i < ivarsCount; i++) {
            [ivarNames addObject:[NSString stringWithUTF8String:ivar_getName(ivars[i])]];
        }
    }

    free(ivars);
    
    return  ivarNames;
}


- (NSArray*)ivarNamesAndTypes {


    NSMutableArray *ivarNamesAndTypes = [[NSMutableArray alloc] init];

    NSArray *ivars = [self ivarWrappers];


    for (M4IvarWrapperAbstract *ivarWrapper in ivars) {

        [ivarNamesAndTypes addObject:[NSString stringWithFormat:@"%@  %@", ivarWrapper.stringType, ivarWrapper.name]];
    }


    return ivarNamesAndTypes;
}


- (NSString *)ivarDescriptionWithName:(NSString *)ivarName {

    NSString *ivarDescription = nil;

    //get the list of internal variables
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &ivarsCount);



    for (int i = 0; i < ivarsCount; i++) {

        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivars[i])];

        if ([ivarName isEqualToString:name]) {

            M4IvarWrapperFactory *factory = [[M4IvarWrapperFactory alloc] init];
            M4IvarWrapperAbstract *wrapper = [factory wrapperWithIvar:ivars[i]];
            ivarDescription = [wrapper stringValueWithObject:self];
            break;
        }
    }

    free(ivars);

    return [self prettyStringFromDescription:ivarDescription];
}



- (NSArray*)ivarWrappers {

    NSMutableArray *ivarArray = nil;

    //get the list of internal variables
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &ivarsCount);

    if (ivarsCount > 0) {

        ivarArray = [[NSMutableArray alloc] initWithCapacity:ivarsCount];
        M4IvarWrapperFactory *factory = [[M4IvarWrapperFactory alloc] init];

        for (int i = 0; i < ivarsCount; i++) {

            [ivarArray addObject:[factory wrapperWithIvar:ivars[i]]];
        }
    }

    free(ivars);

    return  ivarArray;
}





- (NSString*)prettyStringFromDescription:(NSString*)description {

    NSMutableString *prettyString = [[NSMutableString alloc] init];

    const char *originalString = [description UTF8String];

    NSMutableString *spaceString = [[NSMutableString alloc] init];
    NSString *spaceStep = @"    ";

    char ch = originalString[0];

    for (int i = 0; ch != '\0'; i++) {

        ch = originalString[i];

        [prettyString appendFormat:@"%c", ch];

        if (ch == '\n') {
            
            if (originalString[i-1] == '{') {

                [spaceString appendString:spaceStep];

            }
            if (originalString[i+1] == '}') {

                [spaceString replaceCharactersInRange:NSMakeRange(0, spaceStep.length)
                                           withString:@""];
            }

            [prettyString appendString:spaceString];
        }
    }

    return prettyString;
}



@end
