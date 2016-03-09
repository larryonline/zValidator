//
//  zValidatorProtocol.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#ifndef zValidatorProtocol_h
#define zValidatorProtocol_h



#pragma mark - protocol
@protocol zRule, zComplexRule, zValidator;

/**
 * Basic Protocol
 */
@protocol zRule <NSObject, NSCopying>

@property (nonatomic, weak) id<zValidator> root;
@property (nonatomic, weak) id<zComplexRule> parent;

-(BOOL)validate:(id)data;
@end

/**
 * Complex Rule Protocol
 */
@protocol zComplexRule <zRule>
@property (nonatomic, copy) NSArray<id<zRule>> *subRules;
-(void)addSubRule:(id<zRule>) rule;
@end


/**
 * Validator Protocol
 */
@protocol zValidator <NSObject>

@property (nonatomic, strong) id target;

@property (nonatomic, copy, readonly) NSArray<NSString *> *failedMessageList;
@property (nonatomic, copy, readonly) NSString *failedMessage;

-(void)addRule:(id<zRule>)rule withFailedMessage:(NSString *)message;

-(BOOL)validate;
@end

#pragma mark - Block

typedef BOOL (^zValidation)(id data);

#endif /* zValidatorProtocol_h */
