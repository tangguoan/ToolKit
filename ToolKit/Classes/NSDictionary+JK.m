//
//  NSDictionary+JK.m
//  demo
//
//  Created by tangguoan on 2019/7/8.
//  Copyright © 2019 com.jianke.handhelddoctorMini. All rights reserved.
//

#import "NSDictionary+JK.h"

#import <objc/runtime.h>

@implementation NSDictionary (JK)

+ (void)load {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
        Method originalMethod = class_getInstanceMethod([NSDictionary class], @selector(moa_dictionaryWithObjects:forKeys:count:));
        
        Class aCl = NSClassFromString(@"__NSPlaceholderDictionary");
        
        SEL s = NSSelectorFromString(@"initWithObjects:forKeys:count:");
        
        id tmp = [aCl performSelector:s];
        Method swizzledMethod = class_getInstanceMethod(aCl, s);
         method_exchangeImplementations(originalMethod, swizzledMethod);
        
//        NSLog(@"是否交换  %ld",b);
    });
    
}


- (instancetype)moa_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            NSLog(@"error: key is nil");
            continue;
        }
        if (!obj) {
            NSLog(@"error: anObject is nil");
            continue;
        }
        
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self moa_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end
