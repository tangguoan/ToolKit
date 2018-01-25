//
//  NSString+width.h
//
//  Created by renyibag.com on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (width)
-(CGFloat)heightWithFont:(UIFont *)font withinWidth:(float)width;
-(CGFloat)widthWithFont:(UIFont *)font;

//单行uilabel 的宽度
-(CGFloat)labelOfwidthOneLineWithFont:(UIFont *)font;

+ (NSString *)calculateTime:(NSInteger)time;

/**
 计算百千 万
 @param number
 @return
 */
+(NSString *)calculateSimpleNumber:(NSInteger)number;
@end
