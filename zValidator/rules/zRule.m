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

@synthesize validator = _validator, uuid = _uuid;

+(NSString *)makeUUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

-(void)dealloc{
    self.uuid = nil;
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
