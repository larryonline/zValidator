//
//  zRuleAND.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRule.h"

@interface zRuleAND : zRule<zComplexRule>

-(id)initWithSubRules:(NSArray<id<zRule>> *)subRules;

@end

@interface zRuleAND(Chaining)
-(zRuleAND *(^)(id<zRule>))AND;
@end
