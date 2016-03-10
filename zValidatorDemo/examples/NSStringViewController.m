//
//  ViewController.m
//  zValidator
//
//  Created by ZhangZhenNan on 16/3/9.
//  Copyright © 2016年 zhennan. All rights reserved.
//

#import "NSStringViewController.h"
#import "NSString+zValidator.h"
#import "NSArray+zValidator.h"
@interface NSStringViewController ()
@property (weak, nonatomic) IBOutlet UITextView *consoleDisplay;

@end

@implementation NSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressRun:(id)sender {
    
    NSDate *now = [NSDate date];
    
    NSArray *validators = [self logics];
    
    self.consoleDisplay.text = [NSString stringWithFormat:@"%@\n===============\n%@", self.consoleDisplay.text, [validators failedMessageForContents]];
    
    NSTimeInterval second = [[NSDate date] timeIntervalSinceDate:now];
    
    self.consoleDisplay.text = [NSString stringWithFormat:@"%@\n\elapsed:%fs", self.consoleDisplay.text, second];
    
}

-(NSArray *)logics{
    
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
    
    // Put the code you want to measure the time of here.
//    NSAssert([validators validateContents], [validators failedMessageForContents]);
    return validators;
    
}


@end
