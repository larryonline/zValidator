//
//  NSString+zValidator.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+zValidator.h"
#import "zValidator+Chaining.h"
#import "zBlockRule.h"

@interface NSString(zValidator)
-(zValidator *)zzn;

@end

@interface zRule(ChainingForNSString)

-(instancetype)isNSString;
-(instancetype)notNSString;

-(instancetype)isEmpty;
-(instancetype)notEmpty;

-(zRule *(^)(NSString *content))contains;
-(zRule *(^)(NSString *regexp))match;

-(zRule *(^)(NSUInteger length))lengthEqual;
-(zRule *(^)(NSUInteger val))greaterThan;
-(zRule *(^)(NSUInteger val))lessThan;
-(zRule *(^)(NSUInteger min, NSUInteger max))inRange;
@end

@interface zRule(ChainingForNSStringUtils)
-(instancetype)isEmail;
-(instancetype)isDigit;
-(instancetype)isNumeric;
@end

@interface zRule(ChaningForNSStringChinaUtils)
-(instancetype)isChinaMobilePhoneNumber;
@end


// xCode don't have ablity to check return type of returning block. 😞😞😞
// so i need write these 💩💩💩 below.

@interface zRuleAND(ChainingForNSString)
-(zRuleAND *(^)(NSString *content))contains;
-(zRuleAND *(^)(NSString *regexp))match;
-(zRuleAND *(^)(NSUInteger length))lengthEqual;
-(zRuleAND *(^)(NSUInteger val))greaterThan;
-(zRuleAND *(^)(NSUInteger val))lessThan;
-(zRuleAND *(^)(NSUInteger min, NSUInteger max))inRange;
@end

@interface zRuleOR(ChainingForNSString)
-(zRuleOR *(^)(NSString *content))contains;
-(zRuleOR *(^)(NSString *regexp))match;
-(zRuleOR *(^)(NSUInteger length))lengthEqual;
-(zRuleOR *(^)(NSUInteger val))greaterThan;
-(zRuleOR *(^)(NSUInteger val))lessThan;
-(zRuleOR *(^)(NSUInteger min, NSUInteger max))inRange;
@end