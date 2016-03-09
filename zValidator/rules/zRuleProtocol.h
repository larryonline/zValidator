//
//  zRuleProtocol.h
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#ifndef zRuleProtocol_h
#define zRuleProtocol_h

// simple rule
@protocol zRule <NSObject, NSCopying>
@property (nonatomic, copy, readonly) NSString *uuid;
-(BOOL)validate:(id)data;
@end


// complex rule
@protocol zComplexRule <zRule>

@property (nonatomic, copy, readonly) NSArray<id<zRule>> *subRules;

-(void) addSubRule:(id<zRule>)rule;


-(void) removeSubRule:(id<zRule>)rule;
-(id<zRule>)removeSubRowWithIndex:(NSUInteger)index;
@end

#endif /* zRuleProtocol_h */
