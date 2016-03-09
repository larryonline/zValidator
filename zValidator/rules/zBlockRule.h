//
//  zBlockRule.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRule.h"

typedef BOOL (^zRuleBlock)(id data);

@interface zBlockRule : zRule

@property (nonatomic, copy, readonly) zRuleBlock rule;

-(id)initWithRuleBlock:(zRuleBlock)ruleBlock;

@end
