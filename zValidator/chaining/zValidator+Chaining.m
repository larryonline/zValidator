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

-(zBlockRule *(^)(NSString *))check{
    return ^(NSString *assertion){
        zBlockRule *rule = [[zBlockRule alloc] init];
        [self addRule:rule withFailedMessage:assertion];
        return rule;
    };
}

-(zValidator *(^)(NSString *, zValidation))checkIs{
    return ^(NSString *assertion, zValidation block){
        return self.check(assertion).is(block).also;
    };
}

-(zValidator *(^)(NSString *, zValidation))alsoCheckIs{
    return ^(NSString *assertion, zValidation block){
        return self.check(assertion).is(block).also;
    };
}


-(zRuleAND *(^)(NSString *))checkAndIs{
    return ^(NSString *assertion){
        zRuleAND *rule = [[zRuleAND alloc] init];
        [self addRule:rule withFailedMessage:assertion];
        return rule;
    };
}

-(zRuleAND *(^)(NSString *, zValidation))checkIsAndIs{
    return ^(NSString *assertion, zValidation block){
        return self.checkAndIs(assertion).andIs(block);
    };
}

-(zRuleAND *(^)(NSString *, zValidation))alsoCheckIsAndIs{
    return ^(NSString *assertion, zValidation block){
        return self.checkAndIs(assertion).andIs(block);
    };
}


-(zRuleOR *(^)(NSString *))checkOrIs{
    return ^(NSString *assertion){
        zRuleOR *rule = [[zRuleOR alloc] init];
        [self addRule:rule withFailedMessage:assertion];
        return rule;
    };
}

-(zRuleOR *(^)(NSString *, zValidation))checkIsOrIs{
    return ^(NSString *assertion, zValidation block){
        return self.checkOrIs(assertion).orIs(block);
    };
}

-(zRuleOR *(^)(NSString *, zValidation))alsoCheckIsOrIs{
    return ^(NSString *assertion, zValidation block){
        return self.checkOrIs(assertion).orIs(block);
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

-(zRule *(^)(zValidation))is{
    return ^(zValidation block){
        NSAssert(NO, @"subclass should override this method");
        return self;
    };
}

@end

@implementation zBlockRule(Chaining)

-(zBlockRule *(^)(zValidation))is{
    return ^(zValidation block){
        self.block = block;
        return self;
    };
}

@end

@implementation zComplexRule(Chaining)

-(zComplexRule *(^)(zValidation))is{
    return ^(zValidation block){
        zBlockRule *subRule = [[zBlockRule alloc] init];
        subRule.block = block;
        [self addSubRule:subRule];
        return self;
    };
}

@end

@implementation zRuleAND(Chaining)

-(zRuleAND *)and{
    return self;
}

-(zRuleAND *(^)(zValidation))andIs{
    return ^(zValidation block){
        return self.is(block);
    };
}

@end

@implementation zRuleOR(Chaining)

-(zRuleOR *)or{
    return self;
}

-(zRuleOR *(^)(zValidation))orIs{
    return ^(zValidation block){
        return self.is(block);
    };
}

@end
