//
//  NSString+width.h
//
//  Created by com on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (label)

-(CGFloat)labelOfheightMultilineWithFont:(UIFont *)fontM LayoutWidth:(float)width;
//单行uilabel 的宽度
-(CGFloat)labelOfwidthOneLineWithFont:(UIFont *)font;
@end
