//
//  zComplexRule.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zComplexRule.h"

@implementation zComplexRule
-(void)dealloc{
    self.subRules = nil;
}

-(id)init{
    if(self = [super init]){
        self.subRules = @[];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    zComplexRule *result = [[[self class] allocWithZone:zone] init];
    result.uuid = self.uuid;
    result.subRules = self.subRules;
    return result;
}

-(void)addSubRule:(id<zRule>)rule{
    if(![self.subRules containsObject:rule]){
        self.subRules = [self.subRules arrayByAddingObject:rule];
        rule.parent = self;
    }
}

@end
