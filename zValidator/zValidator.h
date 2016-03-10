//
//  ZNValidator.h
//  NSString+Validator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "zValidatorProtocol.h"

@interface zValidator : NSObject<zValidator>
@property (nonatomic, strong) id target;

-(NSString *)failedMessageForRule:(id<zRule>)rule;

-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message;

-(BOOL)validate;
@end

