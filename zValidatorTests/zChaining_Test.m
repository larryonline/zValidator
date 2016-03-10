//
//  zChaining_Test.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "zValidator+Chaining.h"
@interface zChaining_Test : XCTestCase

@end

@implementation zChaining_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testChaining{
    
    zValidator *v = zValidator.new.checkIs(@"target should be NSArray", ^BOOL(id data){
        
        return [data isKindOfClass:[NSArray class]];
        
    }).checkIsAndIs(@"target length should be 4, and the sub item should all be NSString", ^BOOL(id data){
        
        return 4 == [data count];
        
    }).andIs(^BOOL(id data){
        
        BOOL ret = YES;
        for(NSInteger i = 0; i < [data count]; i++){
            if(![[data objectAtIndex:i] isKindOfClass:[NSString class]]){
                ret = NO;
                break;
            }
        }
        return ret;
        
    }).
    also.checkIsOrIs(@"the first item should be 'a' or 'b' or 'c'. ", ^BOOL(id data){
        
        return [@"a" isEqualToString:[data objectAtIndex:0]];
        
    }).orIs(^BOOL(id data){
        
        return [@"b" isEqualToString:[data objectAtIndex:0]];
        
    }).orIs(^BOOL(id data){
        
        return [@"c" isEqualToString:[data objectAtIndex:0]];
        
    }).validator;
    
    
    NSArray * mockList = @[
        @"I am not NSarray. sorry.",
        @[@"i", @"am", @"NSArray. yeah~~"],
        @[@"i am NSArray with NSNumber items", @1, @2, @3],
        @[@"a", @"i", @"am", @"the NSArray which have superpower to pass this test"]
    ];
    
    for(NSInteger i = 0; i < [mockList count]; i++){
        id mock = [mockList objectAtIndex:i];
        v.target = mock;
        [v validate];
        NSLog(@"\n=====================\n%@\n%@\n==================", mock, [v failedMessage]);
//        NSAssert([v validate], [v failedMessage]);
    }

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
