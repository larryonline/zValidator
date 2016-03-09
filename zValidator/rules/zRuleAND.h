//
//  zRuleAND.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRule.h"

@interface zRuleAND : zRule<zComplexRule>
@property (nonatomic, copy) NSArray<id<zRule>> *subRules;
@end