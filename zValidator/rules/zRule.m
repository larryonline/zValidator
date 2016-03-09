//
//  zRule.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zRule.h"

@interface zRule()
+(NSString *)makeUUID;
@end

@implementation zRule

@synthesize root = _root, parent = _parent, uuid = _uuid;


+(NSString *)makeUUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

-(zValidator *)root{
    if(nil == _root){
        if(nil != _parent){
            return _parent.root;
        }
    }
    return _root;
}

-(void)dealloc{
    self.uuid = nil;
    self.root = nil;
    self.parent = nil;
}

-(id)init{
    if(self = [super init]){
        self.uuid = [[[self class] makeUUID] copy];
    }
    return self;
}

-(BOOL)validate:(id)data{
    // default implementation
    // subclass should override this method
    return NO;
}

-(id)copyWithZone:(NSZone *)zone{
    zRule *result = [[[self class] allocWithZone:zone] init];
    result.uuid = self.uuid;
    return result;
}

-(BOOL)isEqual:(id)object{
    return [object isKindOfClass:[zRule class]] && [self.uuid isEqualToString:[(zRule *)object uuid]];
}

-(NSUInteger)hash{
    return  [[self class] hash] ^ [self.uuid hash];
}

@end
