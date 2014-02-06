//
//  objctestTests.m
//  objctestTests
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

#import <XCTest/XCTest.h>
#import "NSObject+IvarPrint.h"


typedef struct level1Tag level1;

struct level1Tag {
    int anInt;
};


typedef struct level2Tag level2;
struct level2Tag {

    int l2;
    level1 sl1;
};



typedef struct level3Tag level3;
struct level3Tag {
    float l1;
    level2 sl2;
    level1 sl1;
    BOOL b1;
};


@interface DummyClass : NSObject
@end


@implementation DummyClass {

    level1 _structLevel1;
    level2 _structLevel2;
}
@end


@interface objctestTests : XCTestCase

@end

@implementation objctestTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNestedStructLevel1
{
    DummyClass *dummy = [[DummyClass alloc] init];

    NSString *expectedString =
    @"DummyClass {\n"
    @"    level1Tag _structLevel1 = {\n"
    @"        int anInt = 0\n"
    @"    }\n"

    @"    level2Tag _structLevel2 = {\n"
    @"        int l2 = 0\n"
    @"        level1Tag sl1 = {\n"
    @"            int anInt = 0\n"
    @"        }\n"
    @"    }\n"
    @"}";

    //exercise
    NSString *ivarDescriptions = [dummy ivarDescriptions];

    XCTAssertEqualObjects(ivarDescriptions, expectedString, @"");
}


@end
