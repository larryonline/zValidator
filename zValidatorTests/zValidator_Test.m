//
//  zValidator_Test.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "zValidator.h"
@interface zValidator_Test : XCTestCase

@end

@implementation zValidator_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    id mock = @[@"a", @"b", @"c", @"d"];
//    id mock = @[@"a"];
    
    
    zValidator *v =  zValidator.target(mock)
    .must(@"must be subclass of NSArray", ^BOOL(id data){
        
        return [data isKindOfClass:[NSArray class]];
        
    }).must(@"must have 4 sub items", ^BOOL(id data){
        
        return 4 == [data count];
    
    }).should(@"the first sub item should be 'a'", ^BOOL(id data){
        
        return [@"a" isEqualToString:[data objectAtIndex:0]];
        
    }).should(@"the second sub item should be 'b'", ^BOOL(id data){
        
        return [@"b" isEqualToString:[data objectAtIndex:1]];
        
    }).should(@"the third sub item should be 'c' or 'f'", ^BOOL(id data){
        
        id item = [data objectAtIndex:2];
        return [@"c" isEqualToString:item] || [@"f" isEqualToString:item];
        
    });
    
    NSAssert([v validate], @"%@", [v failedMessage]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
