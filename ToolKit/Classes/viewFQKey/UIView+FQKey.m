//
//  UIView+bjckKey.m
//  Pods
//
//  Created by Randy on 15/11/27.
//
//

#import "UIView+FQKey.h"
#import <objc/runtime.h>

static char FQViewObjectKey;
static char FQViewObjectKeyselected;

@implementation UIView (FQKey)

- (id)fq_key
{
    return objc_getAssociatedObject(self, &FQViewObjectKey);
}

- (void)setFq_key:(id)fq_key
{
    objc_setAssociatedObject(self, &FQViewObjectKey,fq_key,OBJC_ASSOCIATION_RETAIN);
}


- (BOOL)fq_selected
{
    NSNumber *number = objc_getAssociatedObject(self, &FQViewObjectKeyselected);
    return [number boolValue];
}

- (void)setFq_selected:(BOOL)fq_selected
{
    objc_setAssociatedObject(self, &FQViewObjectKeyselected,@(fq_selected),OBJC_ASSOCIATION_ASSIGN);
}

@end
