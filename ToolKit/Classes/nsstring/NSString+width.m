//
//  NSString+width.m
//
//  Created by renyibang.com on 15/7/31.
//  Copyright (c) 2017年 sczy. All rights reserved.
//


#import "NSString+width.h"

@implementation NSString (width)
- (CGFloat) heightWithFont: (UIFont *) font withinWidth: (float) width
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return ceil(textRect.size.height);
}

- (CGFloat)widthWithFont:(UIFont *) font
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    return textRect.size.width;
}

-(CGFloat)labelOfwidthOneLineWithFont:(UIFont *)font
{
    UILabel *lable = [UILabel new];
    lable.numberOfLines = 1;
    lable.font = font;
    lable.text = self;
    return [lable intrinsicContentSize].width;
}


+ (NSString *)calculateTime:(NSInteger)time{
    if (time == 0) {
        return @"00:00";
    }
    NSString *shijian = @"";
    NSInteger hour = time / 3600;
    NSInteger houryushu = time % 3600;
    NSInteger fen = houryushu / 60;
    NSInteger fenyushu = houryushu % 60;
    if (hour > 0) {
        shijian = [NSString stringWithFormat:@"%.2ld:",hour];
    }
    shijian = [NSString stringWithFormat:@"%@%.2ld:%.2ld",shijian,fen,fenyushu];
    return  shijian;
}

+(NSString *)calculateSimpleNumber:(NSInteger)number;{
    //万位
    NSInteger w = number/10000;
    NSInteger w_y = number%10000;
    //千位
    NSInteger k = w_y/1000;
    NSInteger k_y = w_y%1000;

    //百位
    NSInteger b = k_y/100;
    NSInteger b_y = k_y%100;

    //十位
    NSInteger s = b_y/10;

    if (number < 1000) {
        return [NSString stringWithFormat:@"%ld",number];
    }

    NSString *length = @(number).stringValue;
    if (length.length == 4) {
        if (s >= 5) {
            b = b + 1;
        }
        if (b == 10) {
            b = 0;
            k = k + 1;
        }
        if (k == 10) {
            k = 0;
            w = w + 1;
        }
        if (w > 0) {
            return [NSString stringWithFormat:@"%ld.%ldw",w,k];
        }
        if (k > 0) {
            return [NSString stringWithFormat:@"%ld.%ldk",k,b];
        }
    }
        //==============
    if (length.length >= 5) {
        if (b >= 5) {
            k = k + 1;
        }
        if (k == 10) {
            k = 0;
            w = w + 1;
        }
        return [NSString stringWithFormat:@"%ld.%ldw",w,k];
    }
    return @"0";
}
@end
