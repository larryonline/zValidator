- zValidator

lib for NSObject validation.



```
    zValidator *v = zValidator.target(nil).makesure(@"target should be NSArray", ^BOOL(id data){

        return [data isKindOfClass:[NSArray class]];

    }).
    also.makesure_a(@"target length should be 4, and the sub item should all be NSString", ^BOOL(id data){

        return 4 == [data count];

    }).and(^BOOL(id data){

        BOOL ret = YES;
        for(NSInteger i = 0; i < [data count]; i++){
            if(![[data objectAtIndex:i] isKindOfClass:[NSString class]]){
                ret = NO;
                break;
            }
        }
        return ret;

    }).
    also.makesure_o(@"the first item should be 'a' or 'b' or 'c'. ", ^BOOL(id data){

        return [@"a" isEqualToString:[data objectAtIndex:0]];

    }).or(^BOOL(id data){

        return [@"b" isEqualToString:[data objectAtIndex:0]];

    }).or(^BOOL(id data){

        return [@"c" isEqualToString:[data objectAtIndex:0]];

    }).validator;

    NSArray * mockList = @[
        @"I am not NSarray. sorry.",
        @[@"i", @"am", @"NSArray. yeah~~"],
        @[@"i am NSArray with NSNumber items", @1, @2, @3],
        @[@"a", @"i", @"am", @"the NSArray which have superpower to pass this test"]
    ];

    for(NSInteger i = 0; i < [mockList count]; i++){
        id mock = [mockList objectAtIndex:i];
        v.target = mock;
        // NSAssert([v validate], [v failedMessage]);
        NSLog(@"Target: %@\nError:  %@", mock, [v failedMessage]);
    }
```