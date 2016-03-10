//
//  zComplexRule.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zRule.h"

@interface zComplexRule : zRule<zComplexRule>
@property (nonatomic, copy) NSArray<id<zRule>> *subRules;
@end
