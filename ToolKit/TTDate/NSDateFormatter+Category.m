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

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+ (instancetype)dateFormatter
{
    return [[self alloc] init];
}

+ (instancetype)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (instancetype)defaultDayDateFormatter
{
    static NSDateFormatter *dayDateFormatter = nil;
    if (!dayDateFormatter) {
        dayDateFormatter = [[self alloc] init];
    }
    dayDateFormatter.dateFormat = @"yyyy.MM.dd";
    return dayDateFormatter;
}

+ (instancetype)defaultDayDateFormatter2
{
    static NSDateFormatter *dayDateFormatter = nil;
    if (!dayDateFormatter) {
        dayDateFormatter = [[self alloc] init];
    }
    dayDateFormatter.dateFormat = @"yyyy-MM-dd";
    return dayDateFormatter;
}

+ (instancetype)defaultDateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[self alloc] init];
    }
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

+ (instancetype)defaultDateFormatter2
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[self alloc] init];
    }
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return dateFormatter;
}

+ (instancetype)defaultOnlyHourDateFormatter//dd
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[self alloc] init];
    }
    dateFormatter.dateFormat = @"dd";
    return dateFormatter;
}

+ (instancetype)defaultWeek
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[self alloc] init];
    }
    dateFormatter.shortWeekdaySymbols = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    dateFormatter.dateFormat = @"EE";
    return dateFormatter;
}

@end
