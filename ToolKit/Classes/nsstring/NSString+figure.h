//
//  NSString+width.h
//
//  Created by renyibag.com on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (figure)

/*
 *  会四舍五入进位
 *  进位后,尾部有0的会去掉
 *  digit 位数 figure原始的数据
 *
 */
+ (NSString *)decimalPointWithdispose:(int)digit Andoriginalfigure:(CGFloat)figure;

@end
