//
//  LSVoteDateManager.h
//  TXLS
//
//  Created by tangguoan on 2018/4/17.
//  Copyright © 2018年 lashou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSVoteDateManager : NSObject

+ (instancetype)shareInstance;

@property(strong,nonatomic, readonly)NSDateFormatter *formatter;
@property(assign,nonatomic)NSInteger hour;
@property(assign,nonatomic)NSInteger yymmrr;

// 初始化小时
-(NSString *)getCurrentHour:(NSInteger)index;
// 初始化YYMMDD
-(NSString *)getCurrentyymmrr:(NSInteger)index;


// 格式化转化  时间字符串转化成时间对象
-(NSDate *)transformFormaterYYMMRRIdx:(NSInteger)idx1 hhssIdx:(NSInteger)idx2;

// 求默认的小时在的哪一行
-(NSInteger)getHourIdx:(NSDate *)date;
// 求默认的日期在哪一行
-(NSInteger)getyymmrrIdx:(NSDate *)date;
@end
