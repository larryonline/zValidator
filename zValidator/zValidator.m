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
@property (nonatomic, strong) NSMutableSet *priority;

@property (nonatomic, strong) NSMutableDictionary *map;

@property (nonatomic, copy) NSArray *failedMessages;
@end

@implementation zValidator

@synthesize data = _data, order = _order, priority = _priority, map = _map, failedMessages = _failedMessages;

-(NSString *)failedMessage{
    return [self.failedMessages componentsJoinedByString:@"\n"];
}

-(void)dealloc{
    self.order = nil;
    self.priority = nil;
    self.map = nil;
    self.failedMessages = nil;
}

-(id)init{
    if(self = [super init]){
        self.order = [NSMutableArray array];
        self.priority = [NSMutableSet set];
        self.map = [NSMutableDictionary dictionary];
        self.failedMessages = @[];
    }
    return self;
}

-(id)initWithData:(id)data{
    if(self = [self init]){
        self.data = data;
    }
    return self;
}

-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message{
    [self addRule:rule withFailedMessage:message ignoreFollowingRules:NO];
}

-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message ignoreFollowingRules:(BOOL)ignore{
    if(nil != rule){
        [self.order addObject:rule];
        if(ignore){
            [self.priority addObject:rule];
        }
        [self.map setObject:nil == message? @"" : [message copy] forKey:rule];
    }
}


-(BOOL)validate{
    BOOL ret = YES;
    
    NSDictionary *map = [self.map copy];
    NSArray *order = [self.order copy];
    NSArray *priority = [self.priority copy];
    
    for(NSInteger i = 0; i < [order count]; i++){
        id<zRule> rule = [order objectAtIndex:i];
        BOOL ignore = [priority containsObject:rule];

        BOOL val = [rule validate:self.data];
        if(NO == val){
            NSString *failedMessage = [map objectForKey:rule];
            self.failedMessages = [self.failedMessages arrayByAddingObject:[failedMessage copy]];
        }
        
        ret = ret && val;
        
        if(ignore && !val){
            break;
        }
    }
    
    return ret;
}

@end

@implementation zValidator(Chaining)

+(zValidator *(^)(id data))target{
    return ^(id data){
        return [[[self class] alloc] initWithData:data];
    };
}

-(zValidator *(^)(NSString *failedMessage, zRuleBlock block))should{
    return ^(NSString *failedMessage, zRuleBlock block){
        [self addRule:[[zBlockRule alloc] initWithRuleBlock:block] withFailedMessage:failedMessage];
        return self;
    };
}

-(zValidator *(^)(NSString *failedMessage, zRuleBlock block))must{
    return ^(NSString *failedMessage, zRuleBlock block){
        [self addRule:[[zBlockRule alloc] initWithRuleBlock:block] withFailedMessage:failedMessage ignoreFollowingRules:YES];
        return self;
    };
}



-(zValidator *(^)(NSString *failedMessage, id<zRule> rule))rule{
    return ^(NSString *failedMessage, id<zRule> rule){
        [self addRule:rule withFailedMessage:failedMessage];
        return self;
    };
}

-(zValidator *(^)(NSString *failedMessage, id<zRule>rule))ruleMust{
    return ^(NSString *failedMessage, id<zRule>rule){
        [self addRule:rule withFailedMessage:failedMessage ignoreFollowingRules:YES];
        return self;
    };
}

@end
