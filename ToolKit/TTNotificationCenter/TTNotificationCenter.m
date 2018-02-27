//
//  TGANotificationBlock.m
//  TGANotifacation
//
//  Created by 唐--逍遥 on 2016/11/21.
//  Copyright © 2016年 唐--逍遥. All rights reserved.
//

#import "TTNotificationCenter.h"
#import "RYBUrlRouter.h"
@implementation targetObj

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"vc:%@ na:%@ router:%@ key:%@", self.vc, self.na,self.router,self.key];
}

@end

@interface TTNotificationCenter ()
@property(strong, nonatomic) NSMutableDictionary *keyBlockDictionary;

@end

@implementation TTNotificationCenter
static TTNotificationCenter * share = nil;
+ (instancetype)shareInstace
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[self alloc]init];
    });
    return share;
}

- (id)copy
{
    return share;
}

- (id)mutableCopy
{
    return share;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [super allocWithZone:zone];
    });
    return share;
}

// 把block放到数组中去进行保存;
-(void)addObserverNotifi:(id)observer name:(NSString *)aName notifiBlock:(void (^)(targetObj *, id))obj
{
    NSMutableDictionary *dicBlock = [self.keyBlockDictionary valueForKey:aName];
    if (dicBlock == nil) {
        dicBlock = [NSMutableDictionary dictionary];
        [self.keyBlockDictionary setObject:dicBlock forKey:aName];
    }
    [dicBlock setValue:obj forKey:[self changeAddress:observer]];
}


// 移除对象的block回调
- (void)ttDelete:(id)observer{
    NSArray <NSMutableDictionary *>*value = self.keyBlockDictionary.allValues;
    [value enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *otherValue = obj.allKeys;
        NSString *key = [self changeAddress:observer];
        if ([otherValue containsObject:key]) {
            [obj removeObjectForKey:key];
            *stop = YES;
        }
    }];
}

-(void)sendNotifiName:(NSString *)aName notifiInfo:(void (^)(targetObj *, __autoreleasing id *))obj
{
    id response = nil;
    NSMutableDictionary *dictionary = [self.keyBlockDictionary objectForKey:aName];
    targetObj *target = nil;
    if (obj) {
        target = [targetObj new];
        obj(target, &response);
    }

//    去循环得到的保存对象的block 然后执行block传递参数值
    NSArray *value = dictionary.allValues;
    for (void (^block)(targetObj *, __autoreleasing id ) in value) {
        if (block) {
            block(target,response);
        }
    }
}

// 把对象转化成ip地址字符串化
-(NSString *)changeAddress:(id)ip
{
//    __weak id tmp = ip;
//    if (tmp == nil) {
//        return @"";
//    }
    NSString *address = [NSString stringWithFormat:@"%p",ip];
    return address;
}

#pragma mark set get
- (NSMutableDictionary *)keyBlockDictionary
{
    if (!_keyBlockDictionary) {
        _keyBlockDictionary = [NSMutableDictionary dictionary];
    }
    return _keyBlockDictionary;
}
@end
