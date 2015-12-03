//
//  JsonTestingTests.m
//  JsonTestingTests
//
//  Created by Anatoliy Dalekorey on 10/15/15.
//  Copyright © 2015 Anatoliy Dalekorey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

#import "JSONPath.h"

@interface JsonTestingTests : XCTestCase

@property (strong, nonatomic) JSONPath *JSONPathObject;
@property (strong, nonatomic) id JSONDictionaryObject;
@property (strong, nonatomic) id JSONArrayObject;

@end

@implementation JsonTestingTests

- (void)setUp {
    [super setUp];
    
    self.JSONPathObject = [JSONPath new];
    self.JSONDictionaryObject = @{@"name" : @"Izya",
                                  @"organization": @"ZOG",
                                  @"items" : @[
                                          @{@"furnitures" : @8},
                                          @{@"block" : @5}
                                          ]
                                  };
    self.JSONArrayObject = @[@{@"name" : @"Izya"},
                             @{@"organization": @"ZOG"},
                             @{@"items" : @[
                                       @{@"furnitures" : @8},
                                       @{@"block" : @5}
                                       ]
                               }
                             ];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNilPath
{
    NSError *error = nil;
    XCTAssertNil([self.JSONPathObject valueAtPath:nil inJSON:self.JSONDictionaryObject error:&error]);
}

- (void)testEmptyPath
{
    NSError *error = nil;
    XCTAssertNil([self.JSONPathObject valueAtPath:@"" inJSON:self.JSONDictionaryObject error:&error]);
}

- (void)testEmptyObject
{
    NSError *error = nil;
    XCTAssertNil([self.JSONPathObject valueAtPath:@"test.is" inJSON:nil error:&error]);
}

- (void)testIncorrectPath
{
    NSError *error = nil;
    XCTAssertNil([self.JSONPathObject valueAtPath:@"test.is" inJSON:self.JSONDictionaryObject error:&error]);
}

- (void)testCorrectPathDictionaryFirstLevel
{
    NSError *error = nil;
    XCTAssertEqualObjects(@"Izya", [self.JSONPathObject valueAtPath:@"name" inJSON:self.JSONDictionaryObject error:&error]);
}

- (void)testCorrectPathDictionaryArrayFirstLevel
{
    NSError *error = nil;
    XCTAssertEqualObjects(@{@"block" : @5}, [self.JSONPathObject valueAtPath:@"items.1" inJSON:self.JSONDictionaryObject error:&error]);
}

- (void)testCorrectPathDictionarySecondLevel
{
    NSError *error = nil;
    XCTAssertEqualObjects(@8, [self.JSONPathObject valueAtPath:@"items.0.furnitures" inJSON:self.JSONDictionaryObject error:&error]);
}

- (void)testCorrectPathArrayFirstLevel
{
    NSError *error = nil;
    XCTAssertEqualObjects(@{@"name" : @"Izya"}, [self.JSONPathObject valueAtPath:@"0" inJSON:self.JSONArrayObject error:&error]);
}

@end
