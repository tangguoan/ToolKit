/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

+ (instancetype)dateFormatter;
+ (instancetype)dateFormatterWithFormat:(NSString *)dateFormat;

+ (instancetype)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/
+ (instancetype)defaultDateFormatter2;/*yyyy-MM-dd HH:mm*/
+ (instancetype)defaultDayDateFormatter;//yyyy.MM.dd
+ (instancetype)defaultDayDateFormatter2;//yyyy-MM-dd
+ (instancetype)defaultOnlyHourDateFormatter;//dd
+ (instancetype)defaultWeek;// 周几
@end
