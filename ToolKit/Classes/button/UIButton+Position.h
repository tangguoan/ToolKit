
//#import "UIButton+Position.h"
//#import "UIButton+Position.h"
//
//  Created by tangguoan on 2017/10/07.
//  Copyright © 2017年 renyibang. All rights reserved.
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

@interface UIButton (Position)
- (void)imagePositionStyle:(SGImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;
@end
