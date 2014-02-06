//
//  m4IvarWrapperStructureTests.m
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

#import <XCTest/XCTest.h>
#import "M4IvarWrapperStructure.h"
#import "M4IvarWrapperFactory.h"


@interface m4IvarWrapperStructureTests : XCTestCase

@end


@implementation m4IvarWrapperStructureTests {

    M4IvarWrapperFactory *_factory;
}

- (void)setUp {

    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _factory = [[M4IvarWrapperFactory alloc] init];
}

- (void)tearDown {

    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testInitisWithEncodingWhenPointer {

    // setup
    NSString *encode = @"{StructTag}";

    // exercise
    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqualObjects(ivarWrapper.stringType, @"StructTag", @"");
    XCTAssertEqual(ivarWrapper.size, (size_t)0, @"this short form is used only for pointer, so it's not required to have a real size, must be zero");
    XCTAssertEqual(ivarWrapper.encodingLength, (NSUInteger)11, @"11 characters should in the encode string");

    XCTAssertEqualObjects([ivarWrapper stringValueWithObject:nil], @"NULL", @"");
}


- (void)testInitisWithEncodingWithJustAIntAndAFloatWhithOneLevelOfIndirection {

    // setup
    NSString *encode = @"{StructTag=if}";

    // exercise
    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqualObjects(ivarWrapper.stringType, @"StructTag", @"");
    XCTAssertEqual(ivarWrapper.size, sizeof(int) + sizeof(float), @"this short form is used only for pointer, so it's not required to have a real size, must be zero");
    XCTAssertEqual(ivarWrapper.encodingLength, (NSUInteger)14, @"14 characters should in the encode string");

    XCTAssertEqualObjects([ivarWrapper stringValueWithObject:nil], @"NULL", @"");
}


- (void)testInitisWithEncodingWithJustAIntAndAFloat {

    // setup
    NSString *encode = @"{StructTag=\"anint\"i\"anfloat\"f}";

    // exercise
    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqualObjects(ivarWrapper.stringType, @"StructTag", @"");
    XCTAssertEqual(ivarWrapper.size, sizeof(int) + sizeof(float), @"");
    XCTAssertEqual(ivarWrapper.encodingLength, (NSUInteger)30, @"30 characters should in the encode string");
}



#pragma mark - verify encoding length

- (void)testEncodingLengthWithEncodingWhenPointer {

    // setup
    NSString *encode = @"{StructTag}junk";

    // exercise
    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqual(ivarWrapper.encodingLength, (NSUInteger)11, @"11 characters should in the encode string");
}


- (void)testEncodingLengthWithEncodingWithJustAIntAndAFloatWhithOneLevelOfIndirection {

    // setup
    NSString *encode = @"{StructTag=if}someother text";

    // exercise
    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqual(ivarWrapper.encodingLength, (NSUInteger)14, @"14 characters should in the encode string");
}


- (void)testEncodingLengthWithEncodingWithJustAIntAndAFloat {

    // setup
    NSString *encode = @"{StructTag=\"anint\"i\"anfloat\"f}more... i need moore text!!";

    // exercise
    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqual(ivarWrapper.encodingLength, (NSUInteger)30, @"30 characters should in the encode string");
}


#pragma mark - verify nested structs
- (void)testNestedStructs {

    NSString *encode = @"{level2Tag=\"sl2\"{level1Tag=\"sl1\"{StructTag=\"anInt\"i}}}";

    M4IvarWrapperStructure *ivarWrapper = [[M4IvarWrapperStructure alloc] initWithEncoding:encode factory:_factory];

    // verify
    XCTAssertEqual(ivarWrapper.size, sizeof(int), @"");
}

@end
