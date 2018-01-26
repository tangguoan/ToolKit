//
//  TXDate.h
//  BJEducation
//
//  Created by  唐国安 on 10/30/15.
//  Copyright (c) 2015 com.bjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  自定义时间对象
 */
@interface TTDate : NSObject <NSCoding>

/**
 *  返回当前时间的日期对象
 *
 *  @return MCDate*
 */
+ (instancetype)now;

/**
 *  返回以指定毫秒值初始化的日期对象
 *
 *  @param long long 基于1970的毫秒值
 *
 *  @return MCDate*
 */
+ (instancetype)dateWithMilliseconds:(long long)milliseconds;

/**
 *  返回以指定秒值初始化的日期对象
 *
 *  @param NSTimeInterval 基于1970的秒值
 *
 *  @return MCDate*
 */
+ (instancetype)dateWithSeconds:(NSTimeInterval)seconds;

/**
 *  返回以"YYYY-MM-DD"时间串初始化的日期对象
 *
 *  @param dateString 时间串
 *
 *  @return MCDate*
 */
+ (instancetype)dateWithYYYYMMDDString:(NSString *)dateString;

/**
 *  返回以"YYYY-MM-DD HH:MM:SS"时间串初始化的日期对象
 *
 *  @param dateString 时间串
 *
 *  @return MCDate*
 */
+ (instancetype)dateWithYYYYMMDDHHMMSSString:(NSString *)dateString;

/**
 *  返回以"yyyy-MM-dd'T'HH:mm:ss.S+08:00"时间串初始化的日期对象
 *
 *  @param dateString 时间串
 *
 *  @return MCDate*
 */
+ (instancetype)dateWithGreenwichDateString:(NSString *)dateString;

/**
 *  返回日期对应的总毫秒值
 *
 *  @return 12
 */
- (long long)millisecondsSince1970;

/**
 *  返回日期对应的总秒值
 *
 *  @return 12
 */
- (NSTimeInterval)secondsSince1970;

/**
 *  返回日期对应的NSDate
 *
 */
- (NSDate *)date;

/**
 *  返回当前日期的年份
 *
 */
- (NSInteger)year;

/**
 *  返回当前日期的月份
 *
 */
- (NSInteger)month;

/**
 *  返回当前日期的天
 *
 */
- (NSInteger)day;

/**
 *  以"..前"格式显示
 *
 */
- (NSString *)INTERVALAGO;

/**
 *  以“YYYY年MM月DD日 HH时MM分”格式显示
 *
 */
- (NSString *)CNYYYYMMDDHHMM;

/**
 *  以“YYYY-MM-DD HH:MM”格式显示
 *
 */
- (NSString *)ENYYYYMMDDHHMM;


/**
 *  以“MM-DD”格式显示
 *
 */
-(NSString *)MM_DD;


/**
 *  以“YYYY-MM-DD HH:MM:SS”格式显示
 *
 */
- (NSString *)ENYYYYMMDDHHMMSS;

/**
 *  以“MM-DD HH:MM”格式显示
 *
 */
- (NSString *)ENMMDDHHMM;

/**
 *  以“YYYY年MM月DD日”格式显示
 *
 */
- (NSString *)CNYYYYMMDD;

/**
 *  以“YYYY-MM-DD”格式显示
 *
 */
- (NSString *)ENYYYYMMDD;

/**
 *  以“HH时MM分SS秒”格式显示
 *
 */
- (NSString *)CNHHMMSS;

/**
 *  以“HH:MM:SS”格式显示
 *
 */
- (NSString *)ENHHMMSS;

/**
 *  以“HH:MM”格式显示
 *
 */

// 字符串周几
- (NSString *)ENHHMM;

@end
