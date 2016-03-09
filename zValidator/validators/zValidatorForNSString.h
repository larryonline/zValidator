//
//  zValidatorForNSString.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "zValidator.h"

@interface zValidatorForNSString : zValidator
@property (nonatomic, copy) NSString *string;

+(zValidatorForNSString *(^)(NSString *string))target;
@end

@interface zValidatorForNSString(Chaining)

-(zValidatorForNSString *(^)(NSString *failedMessage))mustNotEmpty;

-(zValidatorForNSString *(^)(NSString *failedMessage, NSUInteger min))mustGreaterThanOrEqual;

-(zValidatorForNSString *(^)(NSString *failedMessage, NSUInteger min))mustLessThanOrEqual;

-(zValidatorForNSString *(^)(NSString *failedMessage, NSUInteger min, NSUInteger max))mustGreaterThanOrEqualAndLessThanOrEqual;

-(zValidatorForNSString *(^)(NSString *failedMessage, NSString *regexp))mustMatch;
@end

@interface zValidatorForNSString(ChaningForUtils)

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeNumeric;

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeDigits;

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeEmail;

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeCreditCard;

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeUrl;

@end

@interface zValidatorForNSString(ChainingForChinaMobilePhoneNumber)

-(zValidatorForNSString *(^)(NSString *failedMessage))mustBeChinaMobilePhoneNumber;
@end
