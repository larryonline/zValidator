
## [DEPRECATED] - project is no longer maintained.  
please check [zValidation2](https://github.com/larryonline/zValidator2)

---
# zValidator
lib for NSObject validation.

## NSString VALIDATION SUPPORT

```Objective-C

// zValidatorTests/NSString+zValidator_Test.m

NSArray *validators = @[
    // zRule
    @"".zzn.check(@"target should be instance of NSString").isNSString,
    @"".zzn.check(@"target should be empty").isEmpty,
    @"abc".zzn.check(@"target should not be empty").notEmpty,
    @"xyz".zzn.check(@"target length should be 3 ").lengthEqual(3),
    @"aaaaa".zzn.check(@"target length should greater than 4").greaterThan(4),
    @"aaa".zzn.check(@"target length should less than 4").lessThan(4),
    @"abc".zzn.check(@"target should match regexp : ^abc$").match(@"^abc$"),
    @"abc".zzn.check(@"target should contains 'b'").contains(@"b"),

    // zComplexRule
    @"aaa".zzn.checkAndIs(@"target should not empty and length greater than 2").notEmpty.and.greaterThan(2),

    @"".zzn.checkOrIs(@"target should empty or have 4 characters").isEmpty.or.lengthEqual(4),
    @"aaaa".zzn.checkOrIs(@"target should empty or have 4 characters").isEmpty.or.lengthEqual(4),

    // very long chain
    @"hi, i am zValidator work for NSString.".zzn.
    checkOrIs(@"target should contains 'i am' or 'the' or 'this'").contains(@"i am").or.contains(@"the").or.contains(@"this").
    also.checkAndIs(@"target length should equal 38, and contains 'hi'").lengthEqual(38).and.contains(@"hi"),

    // utils for NSString
    @"1234".zzn.checkAndIs(@"only accept 4 digits").isDigit.and.lengthEqual(4),

    @"-12.123".zzn.check(@"only accept numeric").isNumeric,

    @"18612345678".zzn.check(@"only accept phone number").isChinaMobilePhoneNumber,
    @"15187654321".zzn.check(@"only accept phone number").isChinaMobilePhoneNumber,

    @"my.super.duper-email-address@neverland.domain".zzn.check(@"only accept email address").isEmail,
];

NSAssert([validators validateContents], [validators failedMessageForContents]);

```


## NOT ONLY FOR NSString

### Chain + Block

```Objective-C

// zValidatorTests/zChaining_Test.m

zValidator *v = zValidator.new.checkIs(@"target should be NSArray", ^BOOL(id data){
    return [data isKindOfClass:[NSArray class]];
}).checkIsAndIs(@"target length should be 4, and the sub item should all be NSString", ^BOOL(id data){

    return 4 == [data count];
}).andIs(^BOOL(id data){

    BOOL ret = YES;
    for(NSInteger i = 0; i < [data count]; i++){
        if(![[data objectAtIndex:i] isKindOfClass:[NSString class]]){
            ret = NO;
            break;
        }
    }
    return ret;

}).
also.checkIsOrIs(@"the first item should be 'a' or 'b' or 'c'. ", ^BOOL(id data){

    return [@"a" isEqualToString:[data objectAtIndex:0]];

}).orIs(^BOOL(id data){

    return [@"b" isEqualToString:[data objectAtIndex:0]];

}).orIs(^BOOL(id data){

    return [@"c" isEqualToString:[data objectAtIndex:0]];

}).validator;


NSArray * mockList = @[
    @"sorry, I'm not NSArray.",
    @[@"I", @"am", @"NSArray. Yeah~~"],
    @[@"I am NSArray with NSNumber items", @1, @2, @3],
    @[@"a", @"I", @"am", @"the NSArray which have superpower to pass this test"]
];

for(NSInteger i = 0; i < [mockList count]; i++){
    id mock = [mockList objectAtIndex:i];
    v.target = mock;
    [v validate];
    NSLog(@"\n=====================\n%@\n%@\n==================", mock, [v failedMessage]);
//    NSAssert([v validate], [v failedMessage]);
}
```

## MORE FEATURES COMING SOON.
- UIKit Component Validation
- ...
