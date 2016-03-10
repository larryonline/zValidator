//
//  zRule.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zValidatorProtocol.h"
#import "zValidator.h"

@interface zRule : NSObject<zRule>
@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, strong) zValidator *root;
@property (nonatomic, weak) id<zComplexRule> parent;
@end