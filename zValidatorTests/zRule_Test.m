//
//  ZNVlidationBlockRule_Test.m
//  NSString+Validator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "zBlockRule.h"
#import "zRuleAND.h"
#import "zRuleOR.h"

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

- (void)testRule{
    
    zRule *a = [[zRule alloc] init];
    NSAssert([a isEqual:[a copy]], @"should equal with copy");
    NSAssert([a hash] != [a.uuid hash], @"string should not equal zRule even, zRule have same uuid");
    
    
    zRule *b = [[zRule alloc] init];
    NSAssert(![a isEqual:b], @"should not equal");

    
    NSArray *set = @[a, b];
    NSAssert([set indexOfObject:[a copy]] == 0, @"should find item at index 0");
    NSAssert([set indexOfObject:[b copy]] == 1, @"should find item at index 1");
}

- (void)testBlockRule{
    zBlockRule *rule = [[zBlockRule alloc] init];
    rule.block = ^(id data){
        return [data isKindOfClass:[NSString class]];
    };
    
    NSAssert([rule validate:@""], @"result should be YES");
    NSAssert(![rule validate:@1], @"result should be NO");
}

- (void)testComplexRule_AND{
    
    zRuleAND *rule = [[zRuleAND alloc] init];
    
    zBlockRule *subRuleA = [[zBlockRule alloc] init];
    subRuleA.block = ^BOOL(id data){
        return [data isKindOfClass:[NSString class]];
    };
    
    zBlockRule *subRuleB = [[zBlockRule alloc] init];
    subRuleB.block = ^BOOL(id data){
        return 3 == [data length];
    };
    
    [rule addSubRule:subRuleA];
    [rule addSubRule:subRuleB];
    
    NSAssert([rule validate:@"aaa"], @"result should be YES");
    
    NSAssert(![rule validate:@1], @"result should be NO");
    NSAssert(![rule validate:@"aaaa"], @"result should be NO");
}

- (void)testComplexRule_OR{
    
    zRuleOR *rule = [[zRuleOR alloc] init];
    
    zBlockRule *subRuleA = [[zBlockRule alloc] init];
    subRuleA.block = ^BOOL(id data){
        return [data isKindOfClass:[NSString class]] && 4 > [data length];
    };
    
    zBlockRule *subRuleB = [[zBlockRule alloc] init];
    subRuleB.block = ^BOOL(id data){
        return [data isKindOfClass:[NSString class]] && 6 < [data length];
    };
    
    [rule addSubRule:subRuleA];
    [rule addSubRule:subRuleB];
    
    NSAssert([rule validate:@"aaa"], @"result should be YES");
    NSAssert([rule validate:@"aaaaaaa"], @"result should be YES");
    
    NSAssert(![rule validate:@123456], @"result should be NO");
    NSAssert(![rule validate:@"aaaaa"], @"result should be NO");
    NSAssert(![rule validate:@"aaaaaa"], @"result should be NO");
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
