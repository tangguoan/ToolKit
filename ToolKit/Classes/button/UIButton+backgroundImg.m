//
//  UIButton+ backgroundImg.m
//  renyibang
//
//  Created by tangguoan on 2017/3/16.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//

#import "UIButton+backgroundImg.h"
#import "UIImage+utils.h"
@implementation UIButton (backgroundImg)

-(void)setBackImageNormalColor:(UIColor *)color;{
    UIImage *img = [UIImage fq_imageWithColor:color size:CGSizeMake(1, 1)];
    [self setBackgroundImage:img forState:UIControlStateNormal];
}

-(void)setBackImageHighlightedColor:(UIColor *)color{
    UIImage *img = [UIImage fq_imageWithColor:color size:CGSizeMake(1, 1)];
    [self setBackgroundImage:img forState:UIControlStateHighlighted];
}

@end
