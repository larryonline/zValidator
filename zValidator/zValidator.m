//
//  ZNValidator.m
//  NSString+Validator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zValidator.h"


@interface zValidator()

@property (nonatomic, strong) NSMutableArray *order;
@property (nonatomic, strong) NSMutableDictionary *map;

@property (nonatomic, copy) NSArray *failedMessageList;
@end

@implementation zValidator
@synthesize target = _target, order = _order, map = _map, failedMessageList = _failedMessageList;

-(void)dealloc{
    self.order = nil;
    self.map = nil;
    self.failedMessageList = nil;
}

-(id)init{
    if(self = [super init]){
        self.order = [NSMutableArray array];
        self.map = [NSMutableDictionary dictionary];
        self.failedMessageList = @[];
    }
    return self;
}

-(NSString *)failedMessage{
    NSArray *filtered = [self.failedMessageList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSString class]] && 0 < [evaluatedObject length];
    }]];
    return [filtered componentsJoinedByString:@"\n"];
}

-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message{
    NSAssert(nil != rule, @"rule should not be null!");
    NSAssert(![self.order containsObject:rule], @"rule already exists");
    
    [self.order addObject:rule];
    [self.map setObject:nil == message? @"" : [message copy] forKey:rule];
}


-(BOOL)validate{
    BOOL ret = YES;
    
    NSDictionary *map = [self.map copy];
    NSArray *order = [self.order copy];
    
    for(NSInteger i = 0; i < [order count]; i++){
        id<zRule> rule = [order objectAtIndex:i];

        BOOL val = [rule validate:self.target];
        if(NO == val){
            NSString *failedMessage = [map objectForKey:rule];
            self.failedMessageList = [self.failedMessageList arrayByAddingObject:[failedMessage copy]];
        }
        
        ret = ret && val;
        
        if(!ret){
            break;
        }
    }
    
    return ret;
}

@end
