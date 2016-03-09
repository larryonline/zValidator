//
//  ZNVlidationBlockRule_Test.m
//  NSString+Validator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "zBlockRule.h"
@interface zRule_Test : XCTestCase

@end

@implementation zRule_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlockRule{
    
    zBlockRule *rule = [[zBlockRule alloc] initWithRuleBlock:^BOOL(id data) {
        return YES;
    }];
    
    NSAssert([rule validate:nil], @"result should be <YES>");
    
    rule = [[zBlockRule alloc] initWithRuleBlock:^BOOL(id data) {
        return NO;
    }];
    
    NSAssert(![rule validate:nil], @"result should be <NO>");
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
