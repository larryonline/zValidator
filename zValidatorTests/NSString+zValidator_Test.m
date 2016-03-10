//
//  NSString+zValidator_Test.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+zValidator.h"
#import "NSArray+zValidator.h"
@interface NSString_zValidator_Test : XCTestCase

@end

@implementation NSString_zValidator_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testString{
    
    [self measureBlock:^{
        
        NSArray *validators = @[
            // zRule
            @"".zzn.check(@"target should be instance of NSString").isNSString,
            @"".zzn.check(@"target should be empty").isEmpty,
            @"abc".zzn.check(@"target should not be empty").notEmpty,
            @"xyz".zzn.check(@"target length should be 3 ").lengthEqual(3),
            @"aaaaa".zzn.check(@"target length should greater than 4").greaterThan(4),
            @"aaa".zzn.check(@"target length should less than 4").lessThan(4),
            @"abc".zzn.check(@"target should match regexp : ^abc$").match(@"^abc$"),
            @"abc".zzn.check(@"target should contains 'b'").contains(@"b"),
            
            // zComplexRule
            @"aaa".zzn.checkAndIs(@"target should not empty and length greater than 2").notEmpty.and.greaterThan(2),
            
            @"".zzn.checkOrIs(@"target should empty or have 4 characters").isEmpty.or.lengthEqual(4),
            @"aaaa".zzn.checkOrIs(@"target should empty or have 4 characters").isEmpty.or.lengthEqual(4),
            
            // very long chain
            @"hi, i am zValidator work for NSString.".zzn.
            checkOrIs(@"target should contains 'i' and 'am' and 'NSString'").contains(@"i").or.contains(@"am").or.contains(@"NSString").
            also.checkAndIs(@"target length should equal 38, and contains 'hi'").lengthEqual(38).and.contains(@"hi"),
            
            // utils for NSString
            @"1234".zzn.checkAndIs(@"only accept 4 digits").isDigit.and.lengthEqual(4),
            
            @"-12.123".zzn.check(@"only accept numeric").isNumeric,
            
            @"18600194740".zzn.check(@"only accept phone number").isChinaMobilePhoneNumber,
            @"15101647815".zzn.check(@"only accept phone number").isChinaMobilePhoneNumber,
            
            @"my.super.duper-email-address@neverland.domain".zzn.check(@"only accept email address").isEmail,
        ];
        
        // Put the code you want to measure the time of here.
        NSAssert([validators validateContents], [validators failedMessageForContents]);
    }];
}

-(void)testEdge{
    
}



@end
