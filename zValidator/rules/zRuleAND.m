//
//  zRuleAND.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRuleAND.h"

@interface zRuleAND()

@end

@implementation zRuleAND



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
