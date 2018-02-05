//
//  NSString+width.m
//
//  Created by com on 15/7/31.
//  Copyright (c) 2017年 sczy. All rights reserved.
//


#import "NSString+label.h"

@implementation NSString (label)
-(CGFloat)labelOfheightMultilineWithFont:(UIFont *)fontM LayoutWidth:(float)width;
{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = fontM;
    label.text = self;
    return [label intrinsicContentSize].height;
}

-(CGFloat)labelOfwidthOneLineWithFont:(UIFont *)font
{
    UILabel *label = [UILabel new];
    label.numberOfLines = 1;
    label.font = font;
    label.text = self;
    return [label intrinsicContentSize].width;
}
@end
