//
//  UIButton+ backgroundImg.m
//  renyibang
//
//  Created by tangguoan on 2017/3/16.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//

#import "UIButton+config.h"
#import "UIImage+utils.h"
#import <objc/runtime.h>

char margin;
char type;

@implementation UIButton (config)
-(void)setBackImageNormalColor:(UIColor *)color;{
    UIImage *img = [UIImage fq_imageWithColor:color size:CGSizeMake(1, 1)];
    [self setBackgroundImage:img forState:UIControlStateNormal];
}

-(void)setBackImageHighlightedColor:(UIColor *)color{
    UIImage *img = [UIImage fq_imageWithColor:color size:CGSizeMake(1, 1)];
    [self setBackgroundImage:img forState:UIControlStateHighlighted];
}

- (void)imagePositionStyle:(SGImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing {
    objc_setAssociatedObject(self, &type, @(imagePositionStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &margin, @(spacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (imagePositionStyle == SGImagePositionStyleDefault) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, - 0.5 * spacing, 0, 0.5 * spacing);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
    } else if (imagePositionStyle == SGImagePositionStyleRight) {
        CGFloat imageW = self.imageView.image.size.width;
        CGFloat titleW = self.titleLabel.frame.size.width;
        CGFloat imageOffset = titleW + 0.5 * spacing;
        CGFloat titleOffset = imageW + 0.5 * spacing;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
    }
}

- (SGImagePositionStyle)position
{
    NSNumber *nu = objc_getAssociatedObject(self, &type);
    if ([nu isKindOfClass:[NSNumber class]]) {
        return nu.integerValue;
    }
    return NSNotFound;
}

- (CGFloat)marginSpacing
{
    NSNumber *nu = objc_getAssociatedObject(self, &margin);
    if ([nu isKindOfClass:[NSNumber class]]) {
        return nu.floatValue;
    }
    return 0;
}

- (void)setTtTitle:(NSString *)ttTitle{
    [self setTitle:ttTitle forState:UIControlStateNormal];
}


- (CGSize)intrinsicContentSize{
    CGFloat marginSpacing = self.marginSpacing;
    CGSize size_ = [super intrinsicContentSize];
    if (self.position == SGImagePositionStyleDefault || self.position == SGImagePositionStyleRight) {
        size_.width = size_.width + marginSpacing;
    }
    return size_;
}

//获得单当前的title
- (NSString *)ttTitle{
    return self.currentTitle;
}

- (void)setTtFont:(UIFont *)ttFont{
    self.titleLabel.font = ttFont;
}

- (UIFont *)ttFont{
    return  self.titleLabel.font;
}

- (void)setTtTitleColor:(UIColor *)ttTitleColor{
    [self setTitleColor:ttTitleColor forState:UIControlStateNormal];
}
- (UIColor *)ttTitleColor{
    return self.currentTitleColor;
}
@end
