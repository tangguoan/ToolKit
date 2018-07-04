//
//  UIView+finView.m
//  Pods-RYBTool_Example
//
//  Created by tangguoan on 2018/6/7.
//

#import "UIView+finView.h"

@implementation UIView(finView)
- (NSArray<UIView *> *)findTargetViewWithClass:(Class)targetclass{
    NSMutableArray *targetArray = [NSMutableArray array];
    NSArray *views = [self findSubView:self];
    for (id tmp in views) {
        if ([tmp isKindOfClass:targetclass]) {
            [targetArray addObject:tmp];
        }
    }
    return targetArray.copy;
}

- (NSArray<UIView *> *)findTargetViewWithTag:(NSInteger)tag{
    NSMutableArray *targetArray = [NSMutableArray array];
    NSArray *views = [self findSubView:self];
    for (UIView *tmp in views) {
        if (tmp.tag == tag) {
            [targetArray addObject:tmp];
        }
    }
    return targetArray.copy;
}

/**
 寻找视图的中所有视图并返回一个数组
 */
-(NSArray<UIView *> *)findSubView:(UIView *)contentView{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = contentView.subviews;
    [array addObject:contentView];
    for (UIView *tmp in arr) {
        [array addObjectsFromArray:[self findSubView:tmp]];
    }
    return array;
}
@end
