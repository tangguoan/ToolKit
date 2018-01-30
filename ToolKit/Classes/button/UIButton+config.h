//
//  UIButton+ backgroundImg.h
//  renyibang
//
//  Created by tangguoan on 2017/3/16.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 图片在左，文字在右
    SGImagePositionStyleDefault,
    /// 图片在右，文字在左
    SGImagePositionStyleRight,
    /// 图片在上，文字在下
    SGImagePositionStyleTop,
    /// 图片在下，文字在上
    SGImagePositionStyleBottom,
} SGImagePositionStyle;

@interface UIButton(config)
-(void)setBackImageNormalColor:(UIColor *)color;
-(void)setBackImageHighlightedColor:(UIColor *)color;
- (void)imagePositionStyle:(SGImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;

@property (assign, nonatomic,readonly)CGFloat marginSpacing;

@property (assign, nonatomic,readonly)SGImagePositionStyle position;

//当前button的标题
@property (strong, nonatomic)NSString *ttTitle;

//当前title的font
@property (strong, nonatomic)UIFont *ttFont;

///当前title 的颜色设置
@property (strong, nonatomic)UIColor *ttTitleColor;
@end
