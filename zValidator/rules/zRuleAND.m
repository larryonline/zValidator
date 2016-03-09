//
//  zRuleAND.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRuleAND.h"

@interface zRuleAND()

@property (nonatomic, copy) NSArray *subRules;

@end

@implementation zRuleAND


-(void)dealloc{
    self.subRules = nil;
}

-(id)initWithSubRules:(NSArray<id<zRule>> *)subRules{
    if(self = [super init]){
        if(nil != subRules){
            self.subRules = [NSArray arrayWithArray:subRules];
        }else{
            self.subRules = @[];
        }
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    zRuleAND *result = [[[self class] allocWithZone:zone] initWithSubRules:self.subRules];
    result.uuid = self.uuid;
    return result;
}

-(void)addSubRule:(id<zRule>)rule{
    if([self.subRules containsObject:rule]){
        self.subRules = [self.subRules arrayByAddingObject:rule];
    }
}

-(void)removeSubRule:(id<zRule>)rule{
    if([self.subRules containsObject:rule]){

        NSMutableArray *temp = [self.subRules mutableCopy];
        [temp removeObject:rule];

        self.subRules = [temp copy];
    }
}

-(id<zRule>)removeSubRowWithIndex:(NSUInteger)index{
    id<zRule> ret = nil;
    if(index < [self.subRules count]){
        ret = [self.subRules objectAtIndex:index];
        NSMutableArray *temp = [self.subRules mutableCopy];
        [temp removeObject:ret];
        self.subRules = [temp copy];
    }
    return ret;
}

-(BOOL)validate:(id)data{
    BOOL ret = YES;
    NSArray *fixed = [self.subRules copy];
    NSUInteger count = [fixed count];

    for(NSInteger i = 0; i < count; i++){
        id<zRule> rule = [fixed objectAtIndex:i];
        ret = ret && [rule validate:data];
        if(NO == ret){
            break;
        }
    }
    
    return ret;
}

@end
