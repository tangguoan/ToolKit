//
//  UIView+fromNib.m
//  Pods-RYBTool_Example
//
//  Created by tangguoan on 2018/7/4.
//

#import "UIView+fromNib.h"

@implementation UIView (fromNib)
+ (instancetype)initFromNib{
    NSString *classxib = [[self class] description];
    NSString *path = [[NSBundle mainBundle]pathForResource:classxib ofType:@"nib"];
    if(path.length == 0){
        NSAssert(NO, @"没有对应的xib文件");
    }
    NSArray<UIView *> *views = [[NSBundle mainBundle]loadNibNamed:[[self class] description] owner:nil options:nil];
        return views.firstObject;
    }
@end
