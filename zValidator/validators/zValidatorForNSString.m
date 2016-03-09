//
//  zValidatorForNSString.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zValidatorForNSString.h"

@implementation zValidatorForNSString

-(NSString *)string{
    return self.data;
}

-(void)setString:(NSString *)string{
    super.data = [string copy];
}

-(void)setData:(id)data{
    NSAssert(NO, @"should not use this method to set data");
}

+(zValidatorForNSString *(^)(NSString *string))target{
    return ^(NSString *string){
        zValidatorForNSString *validator = [[zValidatorForNSString alloc] init];
        validator.string = string;
        return validator;
    };
}

@end

@implementation zValidatorForNSString(Chaining)

-(zValidatorForNSString *(^)(NSString *failedMessage, zRuleBlock rule))zsMust{
    return ^(NSString *failedMessage, zRuleBlock block){
        return (zValidatorForNSString *)self.must(failedMessage, block);
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage))mustNotEmpty{
    return ^(NSString *failedMessage){
        return self.zsMust(failedMessage, ^BOOL(id data){
            return [data isKindOfClass:[NSString class]] && 0 < [data length];
        });
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage, NSUInteger min))mustGreaterThanOrEqual{
    return ^(NSString *failedMessage, NSUInteger min){
        
        return self.zsMust(failedMessage, ^BOOL(id data){
            return [data isKindOfClass:[NSString class]] && min <= [data length];
        });
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage, NSUInteger max))mustLessThanOrEqual{
    return ^(NSString *failedMessage, NSUInteger max){
        return self.zsMust(failedMessage, ^BOOL(id data){
            return [data isKindOfClass:[NSString class]] && max >= [data length];
        });
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage, NSUInteger min, NSUInteger max))mustGreaterThanOrEqualAndLessThanOrEqual{
    return ^(NSString *failedMessage, NSUInteger min, NSUInteger max){
        return self.mustGreaterThanOrEqual(failedMessage, min).mustLessThanOrEqual(failedMessage,max);
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage, NSString *regexp))mustMatch{
    return ^(NSString *failedMessage, NSString *regexp){
        
        return self.zsMust(failedMessage, ^BOOL(id data){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
            return [data isKindOfClass:[NSString class]] && [predicate evaluateWithObject:data];
        });
    };
}

@end

@implementation zValidatorForNSString(ChaningForUtils)



-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeNumeric{
    return ^(NSString *failedMessage){
        return self.mustMatch(failedMessage, @"^[1-9]([0-9]+)?(\\.[0-9]+)?$");
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeDigits{
    return ^(NSString *failedMessage){
        return self.mustMatch(failedMessage, @"^[0-9]+$");
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeEmail{
    return ^(NSString *failedMessage){
        return self.mustMatch(failedMessage, @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$");
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeCreditCard{
    return ^(NSString *failedMessage){
        return self.mustMatch(failedMessage, nil);
    };
}

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeUrl{
    return ^(NSString *failedMessage){
        return self.mustMatch(failedMessage, nil);
    };
}

@end

@implementation zValidatorForNSString(ChainingForChinaMobilePhoneNumber)

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeChinaMobilePhoneNumber{
    return ^(NSString *failedMessage){
        
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189
         */
//        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\\\d{8}$";
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         12         */
//        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\\\d)\\\\d{7}$";
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186
         17         */
//        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\\\d{8}$";
        /**
         20         * 中国电信：China Telecom
         21         * 133,1349,153,180,189
         22         */
//        NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\\\d{7}$";
        
        return self.mustMatch(failedMessage, nil);
    };
}

@end

