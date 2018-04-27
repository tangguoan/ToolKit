//
//  LSVoteDateManager.m
//  TXLS
//
//  Created by tangguoan on 2018/4/17.
//  Copyright © 2018年 lashou. All rights reserved.
//

#import "LSVoteDateManager.h"

@interface LSVoteDateManager ()
@property(nonatomic, strong)NSCalendar *begin_lendar;
@property(nonatomic, strong)NSCalendar *end_lendar;

@property(nonatomic, strong)NSMutableArray *hourSource;
@property(nonatomic, strong)NSMutableArray *yymmddSource;
@property(nonatomic, assign)NSCalendarUnit unit;
@property(nonatomic, strong)NSDate *currentDATE;
@property(strong,nonatomic)NSDateFormatter *formatter;
@end

static LSVoteDateManager *manager = nil;

@implementation LSVoteDateManager

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        self.hourSource = [NSMutableArray array];
        self.yymmddSource = [NSMutableArray array];
        for (NSInteger i =0 ; i < 24; i++) {
            for (NSInteger j = 0; j<2; j++) {
                NSString *tmp = [NSString stringWithFormat:@"%0.2ld:%0.2ld",i,j * (long)30.0];
                [self.hourSource addObject:tmp];
            }
        }
        
        for (NSInteger i = 0; i<30; i++) {
            NSDateComponents *com = [self componentWithday:i * 24.0 * 60.0f * 60.0f];
            NSString *tmp = [NSString stringWithFormat:@"%ld年%0.2ld月%0.2ld日",com.year,com.month,com.day];
            [self.yymmddSource addObject:tmp];
        }
    }
    return self;
}

- (NSInteger)hour{
    return  self.hourSource.count;
}

-(NSInteger)yymmrr{
    return self.yymmddSource.count;
}

- (NSString *)getCurrentHour:(NSInteger)index{
    return  self.hourSource[index];
}

- (NSString *)getCurrentyymmrr:(NSInteger)index{
    return self.yymmddSource[index];
}

- (NSCalendar *)begin_lendar{
    if (!_begin_lendar) {
        _begin_lendar = [NSCalendar currentCalendar];
    }
    return _begin_lendar;
}

-(NSDateComponents *)componentWithday:(NSTimeInterval)dayTime{
    NSDate *afterDate = [self.currentDATE dateByAddingTimeInterval:dayTime];
    NSDateComponents *dateComponents = [self.begin_lendar components:self.unit fromDate:afterDate];
    return dateComponents;
}

- (NSInteger)getHourIdx:(NSDate *)date{
    // H:mm 格式专用
    self.formatter.dateFormat = @"HH:mm";
    return [self.hourSource indexOfObject:[self.formatter stringFromDate:[self getAfter30StartDate:date]]];
}

- (NSDate*)getAfter30StartDate:(NSDate *)date
{
    long timeInterval = [date timeIntervalSince1970];
    long yuTime = (timeInterval%(30*60));
    if (yuTime > 0) {
        timeInterval = timeInterval + (30*60-yuTime);
    }
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

- (NSInteger)getyymmrrIdx:(NSDate *)date{
    self.formatter.dateFormat = @"yyyy年MM月dd日";
    return  [self.yymmddSource indexOfObject:[self.formatter stringFromDate:date]];
}

// 当前的时间
- (NSDate *)currentDATE{
    if (!_currentDATE) {
        _currentDATE = [NSDate date];
    }
    return _currentDATE;
}

- (NSCalendarUnit)unit{
    if (!_unit) {
        _unit = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond;
    }
    return _unit;
}

-(NSDate *)transformFormaterYYMMRRIdx:(NSInteger)idx1 hhssIdx:(NSInteger)idx2{
    [self.formatter setDateFormat:@"yyyy年MM月dd日H:mm"];
    NSString *string = [NSString stringWithFormat:@"%@%@",[self.yymmddSource objectAtIndex:idx1],[self.hourSource objectAtIndex:idx2]];
    NSDate *date = [self.formatter dateFromString:string];
    return date;
}

- (NSDateFormatter *)formatter{
    if (!_formatter) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        _formatter = formatter;
    }
    return _formatter;
}

@end
