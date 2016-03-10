//
//  NSObject+zValidator.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "NSObject+zValidator.h"

@implementation NSObject(zValidator)
-(zValidator *)zValidator{
    return zValidator.target(self);
}
@end
