//
//  UIView+finView.h
//  Pods-RYBTool_Example
//
//  Created by tangguoan on 2018/6/7.
//

#import <UIKit/UIKit.h>
@interface UIView(finView)
/**
 根据类名去寻找对应的目标
 @param targetclass 类名
 @return  数组对象
 */
-(NSArray<UIView *> *)findTargetViewWithClass:(Class)targetclass;

-(NSArray<UIView *> *)findTargetViewWithTag:(NSInteger)tag;
@end
