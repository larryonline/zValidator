//
//  NSArray+zValidator.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zValidator+Chaining.h"
@interface NSArray(zValidator)

-(BOOL)validateContents;
-(NSArray *)failedMessageListForContents;
-(NSString *)failedMessageForContents;
@end
