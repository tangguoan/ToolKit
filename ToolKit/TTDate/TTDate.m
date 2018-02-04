//
//  FQDate.m
//  BJEducation
//
//  Created by 唐国安 on 10/30/15.
//  Copyright (c) 2015 com.bjhl. All rights reserved.
//

#import "TTDate.h"
#import "NSDateFormatter+Category.h"
@interface TTDate() {
    __strong NSDate *_date;
}
@end

@implementation TTDate

+ (instancetype)now
{
    return [[[self class] alloc] initWithDate:[NSDate date]];
}

+ (instancetype)dateWithDate:(NSDate *)date
{
    return [[[self class] alloc]initWithDate:date];
}

+ (instancetype)dateWithMilliseconds:(long long)milliseconds
{
    return [[self class] dateWithSeconds:(NSTimeInterval)milliseconds / 1000];
}

+ (instancetype)dateWithSeconds:(NSTimeInterval)seconds
{
    return [[[self class] alloc] initWithDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
}

+ (instancetype)dateWithYYYYMMDDString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [formatter setTimeZone:timeZone];
    return [[[self class] alloc] initWithDate:[formatter dateFromString:dateString]];
}

+ (instancetype)dateWithYYYYMMDDHHMMSSString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    [formatter setTimeZone:timeZone];
    return [[[self class] alloc] initWithDate:[formatter dateFromString:dateString]];
}

+ (instancetype)dateWithGreenwichDateString:(NSString *)dateString
{
    // TODO:
    return nil;
}

- (long long)millisecondsSince1970
{
    return (long long)([self secondsSince1970] * 1000);
}

- (NSTimeInterval)secondsSince1970
{
    NSTimeInterval seconds = 0.0f;
    if (_date) {
        seconds = [_date timeIntervalSince1970];
    }
    return seconds;
}

- (NSDate *)date
{
    return _date;
}

- (NSInteger)year
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:_date];
    NSInteger year = [comps year];
    return year;
}

- (NSInteger)month
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:_date];
    NSInteger month = [comps month];
    return month;
}

- (NSInteger)day
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:_date];
    NSInteger day = [comps day];
    return day;
}

- (NSString *)INTERVALAGO
{
    FQDate *now = [FQDate now];
    NSTimeInterval interval = [[now date] timeIntervalSinceDate:_date];
    long distance = interval < 0.0f ? 0 : (long)interval;
    
    NSString *sdate = nil;
    
    /*******************************************************************
     *  时间显示规则定义（by 20140305）：
     *  1）距离现在60秒内，显示“刚刚”
     *  2）距离现在超过1分钟但低于30分钟，显示“几分钟前”
     *  3）距离现在超过30分钟但在当天内，显示“HH:MM”
     *  4）距离现在已经是前一天的时间但在当年内，显示“MM-DD”
     *  5）再之前的时间，显示“YYYY-MM-DD”
     *******************************************************************/
    if (distance < 60) {
        sdate = @"刚刚";
    }
    else if (distance < 30 * 60) {
        sdate = [NSString stringWithFormat:@"%ld%@", distance / 60, @"分钟前"];
    }
    else if ((distance < 24 * 60 * 60) && ([now day] == [self day])) {
        sdate = [self ENHHMM];
    }
    else if ([now year] == [self year]) {
        sdate = [self formatDate:@"MM-dd"];
    }
    else {
        sdate = [self ENYYYYMMDD];
    }
    
    return sdate;
}

- (NSString *)minuteDescription
{
    FQDate *currentDate = [FQDate now];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *theDay = [self ENYYYYMMDD];               //日期的年月日
    NSString *currentDay = [currentDate ENYYYYMMDD];    //当前年月日
    
    if ([theDay isEqualToString:currentDay]) {          //今天
        return [self ENHHMM];
    } else if (self.year == currentDate.year) {         //今年
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
        return [dateFormatter stringFromDate:self.date];
    } else {                                            //其它年份
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self.date];
    }
}

- (NSString *)CNYYYYMMDDHHMM
{
    return [self formatDate:@"yyyy年MM月dd日 HH时mm分"];
}

- (NSString *)CNYYYYMMDDHHMMSS
{
    return [self formatDate:@"yyyy年MM月dd日 HH时mm分ss秒"];
}

- (NSString *)ENYYYYMMDDHHMM
{
    return [self formatDate:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)ENYYYYMMDDHHMMSS
{
    return [self formatDate:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)ENMMDDHHMM
{
    return [self formatDate:@"MM-dd HH:mm"];
}

- (NSString *)CNYYYYMMDD
{
    return [self formatDate:@"yyyy年MM月dd日"];
}

- (NSString *)CNMMDD
{
    return [self formatDate:@"MM月dd日"];
}

- (NSString *)ENYYYYMMDD
{
    return [self formatDate:@"yyyy-MM-dd"];
}

- (NSString *)CNHHMMSS
{
    return [self formatDate:@"HH时mm分ss秒"];
}

- (NSString *)ENHHMMSS
{
    return [self formatDate:@"HH:mm:ss"];
}

- (NSString *)ENHHMM
{
    return [self formatDate:@"HH:mm"];
}


- (NSString *)ENEE
{
    return [[NSDateFormatter defaultWeek] stringFromDate:_date];
}
#pragma mark - private method


- (instancetype)initWithDate:(NSDate *)date
{
    if (self = [super init]) {
        if (date) {
            _date = date;
        }
        else {
            _date = [NSDate dateWithTimeIntervalSince1970:0.0f];
        }
    }
    return self;
}

- (void)dealloc
{
    _date = nil;
}

- (NSString *)formatDate:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [formatter setTimeZone:timeZone];
    NSString *dateString = [formatter stringFromDate:_date];
    return dateString;
}


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_date forKey:@"date"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
       _date = [decoder decodeObjectForKey:@"date"];
    }
    return self;
}

@end
