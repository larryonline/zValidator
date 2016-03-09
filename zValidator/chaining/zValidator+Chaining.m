//
//  zValidator+Chaining.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zValidator+Chaining.h"
#import "zBlockRule.h"

@implementation zValidator(Chaining)

+(zValidator *(^)(id target))target{
    return ^(id target){
        zValidator *result = [[zValidator alloc] init];
        result.target = target;
        return result;
    };
}

-(zRule *(^)(NSString *assertion, zValidation block))makesure{
    return ^(NSString *assertion, zValidation block){
        zBlockRule *blockRule = [[zBlockRule alloc] init];
        blockRule.block = block;
        blockRule.root = self;
        
        [self addRule:blockRule withFailedMessage:assertion];
        return blockRule;
    };
}

-(zRuleAND *(^)(NSString *assertion, zValidation))makesure_a{
    return ^(NSString *assertion, zValidation block){
        zRuleAND *rule = [[zRuleAND alloc] init];
        rule.root = self;
        [self addRule:rule withFailedMessage:assertion];
        
        
        zBlockRule *subRule = [[zBlockRule alloc] init];
        subRule.parent = rule;
        subRule.block = block;
        
        [rule addSubRule:subRule];
        return rule;
    };
}

-(zRuleOR *(^)(NSString *assertion, zValidation))makesure_o{
    return ^(NSString *assertion, zValidation block){
        zRuleOR *rule = [[zRuleOR alloc] init];
        rule.root = self;
        [self addRule:rule withFailedMessage:assertion];
        
        zBlockRule *subRule = [[zBlockRule alloc] init];
        subRule.parent = rule;
        subRule.block = block;
        
        [rule addSubRule:subRule];
        return rule;
    };
}
@end

@implementation zRule(Chaining)

-(zValidator *)validator{
    return self.root;
}

-(zValidator *)also{
    return self.root;
}

@end

@implementation zRuleAND(Chaining)

-(zRuleAND *(^)(zValidation))and{
    return ^(zValidation block){
        zBlockRule *subRule = [[zBlockRule alloc] init];
        subRule.parent = self;
        subRule.block = block;
        [self addSubRule:subRule];
        return self;
    };
}

@end

@implementation zRuleOR(Chaining)

-(zRuleOR *(^)(zValidation))or{
    return ^(zValidation block){
        zBlockRule *subRule = [[zBlockRule alloc] init];
        subRule.parent = self;
        subRule.block = block;
        [self addSubRule:subRule];
        return self;
    };
}

@end
