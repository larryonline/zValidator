//
//  NSString+zValidator.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/10.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "NSString+zValidator.h"

@implementation NSString(zValidator)
-(zValidator *)zzn{
    return self.zValidator;
}

@end

@implementation zRule(ChainingForNSString)

-(instancetype)ALWAYS_YES{
    return self.is(^BOOL(id data){
        return YES;
    });
}

-(instancetype)isNSString{
    return self.is(^BOOL(id data){
        return [data isKindOfClass:[NSString class]];
    });
}

-(instancetype)notNSString{
    return self.is(^BOOL(id data){
        return ![data isKindOfClass:[NSString class]];
    });
}

-(instancetype)isEmpty{
    return self.is(^BOOL(id data){
        return nil == data || ([data isKindOfClass:[NSString class]] && 0 == [data length]);
    });
}

-(instancetype)notEmpty{
    return self.is(^BOOL(id data){
        return [data isKindOfClass:[NSString class]] && 0 < [data length];
    });
}

-(zRule *(^)(NSString *content))contains{
    return ^(NSString *content){
        return self.is(^(id data){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", content];
            return [predicate evaluateWithObject:data];
        });
    };
}

-(zRule *(^)(NSString *regexp))match{
    return ^(NSString *regexp){
        return self.is(^(id data){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
            return [predicate evaluateWithObject:data];
        });
    };
}

-(zRule *(^)(NSUInteger length))lengthEqual{
    return ^(NSUInteger val){
        return self.is(^BOOL(id data){
            return val == [data length];
        });
    };
}

-(zRule *(^)(NSUInteger val))greaterThan{
    return ^(NSUInteger val){
        return self.is(^BOOL(id data){
            return val < [data length];
        });
    };
}

-(zRule *(^)(NSUInteger val))lessThan{
    return ^(NSUInteger val){
        return self.is(^BOOL(id data){
            return val > [data length];
        });
    };
}

-(zRule *(^)(NSUInteger min, NSUInteger max))inRange{
    return ^(NSUInteger min, NSUInteger max){
        return self.is(^BOOL(id data){
            NSUInteger val = [data length];
            return min <= val && max >= val;
        });
    };
}
@end

@implementation zRule(ChainingForNSStringUtils)
-(instancetype)isEmail{
    return self.match(@"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$");
}

-(instancetype)isDigit{
    return self.match(@"^[0-9]+$");
}

-(instancetype)isNumeric{
    return self.match(@"^-?[0-9]+(\\.[0-9]+)?$");
}


@end

@implementation zRule(ChainingForNSStringChinaUtils)

-(instancetype)isChinaMobilePhoneNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\\\d{3})\\\\d{7,8}$";
//    id<zRule> rule = self.ALWAYS_YES;
    NSString *failedMessage = [self.validator failedMessageForRule:self];

//    zRuleOR *orRule = self.also.checkOrIs(failedMessage).match(MOBILE);
//    orRule.or.match(CM);
//    orRule.or.match(CU);
//    orRule.or.match(CT);
//    return self;
    
    self.ALWAYS_YES.also.checkOrIs(failedMessage).match(MOBILE).or.match(CM).or.match(CU).or.match(CT);
    return self;
}
@end
