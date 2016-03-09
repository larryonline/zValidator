//
//  zBlockRule.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zBlockRule.h"
@interface zBlockRule()

@end

@implementation zBlockRule

@synthesize block = _block;

-(void)dealloc{
    self.block = nil;
}

-(BOOL)validate:(id)data{
    return self.block(data);
}

-(id)copyWithZone:(NSZone *)zone{
    zBlockRule *result = [[[self class] allocWithZone:zone] init];
    result.uuid = self.uuid;
    result.block = self.block;
    return result;
}

@end
