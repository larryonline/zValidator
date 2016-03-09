//
//  NSString+zValidator.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zValidatorForNSString.h"

@interface NSString(zValidator)

+(zValidatorForNSString *)zForString:(NSString *)string;
-(zValidatorForNSString *)z;

@end
