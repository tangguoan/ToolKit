//
//  NSString+width.m
//
//  Created by renyibang.com on 15/7/31.
//  Copyright (c) 2017年 sczy. All rights reserved.
//


#import "NSString+figure.h"

@implementation NSString (figure)

+(NSString *)decimalPointWithdispose:(int)digit Andoriginalfigure:(CGFloat)figure;
{
    if (digit < 0) {
        NSAssert(NO, @"位数不能是负数,只能是大于0的整数");
    }
    
    digit = pow(10,digit);
    figure = round(figure * digit)/digit;
    return @(figure).stringValue;
}

@end
