//
//  zBlockRule.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zBlockRule.h"
@interface zBlockRule()
@property (nonatomic, copy) zRuleBlock rule;
@end

@implementation zBlockRule

@synthesize rule = _rule;

-(void)dealloc{
    self.rule = nil;
}

-(id)initWithRuleBlock:(zRuleBlock)ruleBlock{
    if(self = [super init]){
        self.rule = [ruleBlock copy];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    zBlockRule *result = [[[self class] allocWithZone:zone] initWithRuleBlock:self.rule];
    result.uuid = self.uuid;
    return result;
}

-(BOOL)validate:(id)data{
    return self.rule(data);
}

@end
