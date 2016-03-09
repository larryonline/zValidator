//
//  zRuleOR.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRule.h"

@interface zRuleOR : zRule
-(id)initWithSubRules:(NSArray<id<zRule>> *)subRules;
@end

@interface zRuleOR(Chaining)
-(zRuleOR *(^)(id<zRule>))OR;
@end
