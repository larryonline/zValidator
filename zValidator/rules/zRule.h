//
//  zRule.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zRuleProtocol.h"

@class zValidator;

@interface zRule : NSObject<zRule>
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, weak) zValidator *validator;

-(BOOL)validate:(id)data;

@end
