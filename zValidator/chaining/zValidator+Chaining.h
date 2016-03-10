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
#import "zBlockRule.h"

@interface zValidator(Chaning)
+(zValidator *(^)(id target))target;


-(zBlockRule *(^)(NSString *))check;

-(zValidator *(^)(NSString *, zValidation))checkIs;



-(zRuleAND *(^)(NSString *))checkAndIs;

-(zRuleAND *(^)(NSString *, zValidation))checkIsAndIs;



-(zRuleOR *(^)(NSString *))checkOrIs;

-(zRuleOR *(^)(NSString *, zValidation))checkIsOrIs;
@end


@interface zRule(Chaining)

-(zValidator *)also;
-(zValidator *)validator;

-(zRule *(^)(zValidation))is;
@end

@interface zBlockRule(Chaining)
-(zBlockRule *(^)(zValidation))is;
@end
@interface zComplexRule(Chaining)
-(zComplexRule *(^)(zValidation))is;
@end


@interface zRuleAND(Chaning)
-(zRuleAND *)and;
-(zRuleAND *(^)(zValidation))is;
-(zRuleAND *(^)(zValidation))andIs;
@end

@interface zRuleOR(Chaning)
-(zRuleOR *)or;
-(zRuleOR *(^)(zValidation))is;
-(zRuleOR *(^)(zValidation))orIs;
@end