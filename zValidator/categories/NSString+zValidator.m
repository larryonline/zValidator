//
//  NSString+zValidator.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "NSString+zValidator.h"

@implementation NSString(zValidator)

+(zValidatorForNSString *)zForString:(NSString *)string{
    return zValidatorForNSString.target(string);
}

-(zValidatorForNSString *)z{
    return zValidatorForNSString.target(self);
}

@end