//
//  zValidator+Chaining.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zValidator.h"
#import "zRule.h"
#import "zRuleAND.h"
#import "zRuleOR.h"


@interface zValidator(Chaining)
+(zValidator *(^)(id target))target;

-(zRule *(^)(NSString *asserion, zValidation))makesure;

-(zRuleAND *(^)(NSString *assertion, zValidation))makesure_a;
-(zRuleOR *(^)(NSString *assertion, zValidation))makesure_o;
@end

@interface zRule(Chaining)
-(zValidator *)also;
-(zValidator *)validator;
@end

@interface zRuleAND(Chaning)
-(zRuleAND *(^)(zValidation))and;
@end

@interface zRuleOR(Chaning)
-(zRuleOR *(^)(zValidation))or;
@end