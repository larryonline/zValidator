//
//  NSArray+zValidator.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "NSArray+zValidator.h"

@implementation NSArray(zValidator)

-(BOOL)validateContents{
    BOOL ret = YES;
    for(NSInteger i = 0; i < [self count]; i++){
        id item = [self objectAtIndex:i];
        if([item isKindOfClass:[zValidator class]]){
            zValidator *validator = (zValidator *)item;
            ret = [validator validate];
        }else if([item isKindOfClass:[zRule class]]){
            zRule *rule = (zRule *)item;
            NSAssert(nil != rule.root, @"rule should be child of some zValidator");
            ret = [rule.root validate];
        }else{
            NSAssert(NO, @"content should be instance of zRule or zValidator");
        }
        
        if(!ret){
            break;
        }
    };
    return ret;
}

-(NSArray *)failedMessageListForContents{
    NSMutableArray *result = [NSMutableArray array];
    for(NSInteger i = 0; i < [self count]; i++){
        id item = [self objectAtIndex:i];
        if([item isKindOfClass:[zValidator class]]){
            zValidator *validator = (zValidator *)item;
            [result addObjectsFromArray:[validator failedMessageList]];
        }else if([item isKindOfClass:[zRule class]]){
            zRule *rule = (zRule *)item;
            NSAssert(nil != rule.root, @"item(zRule) should be child of some zValidator");
            [result addObjectsFromArray:[rule.root failedMessageList]];
        }else{
            NSAssert(NO, @"item should be instance of zRule or zValidator");
        }
    }
    return [result copy];
}

-(NSString *)failedMessageForContents{
    NSArray *failedMessage = [self failedMessageListForContents];
    return [failedMessage componentsJoinedByString:@"\n"];
}

@end
