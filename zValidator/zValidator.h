//
//  ZNValidator.h
//  NSString+Validator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "zRule.h"
#import "zBlockRule.h"

@interface zValidator : NSObject
@property (nonatomic, strong) id data;
@property (nonatomic, copy, readonly) NSArray *failedMessages;

-(NSString *)failedMessage;

-(id)initWithData:(id)data;

-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message;
-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message ignoreFollowingRules:(BOOL)ignore;

-(BOOL)validate;

@end

@interface zValidator(Chaining)

+(zValidator *(^)(id data))target;

-(zValidator *(^)(NSString *failedMessage, zRuleBlock rule))must;
-(zValidator *(^)(NSString *failedMessage, zRuleBlock rule))should;

-(zValidator *(^)(NSString *failedMessage, id<zRule> rule))ruleMust;
-(zValidator *(^)(NSString *failedMessage, id<zRule> rule))rule;

@end

