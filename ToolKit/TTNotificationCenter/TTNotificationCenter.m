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

-(void)addObserveNotifi:(NSString *)aName notifiBlock:(void (^)(targetObj *, id))block
{
    NSMutableArray *arrayBlock = [self.keyBlockDictionary valueForKey:aName];
    if (block) {
        if (arrayBlock == nil) {
            arrayBlock = [NSMutableArray array];
            [self.keyBlockDictionary setObject:arrayBlock forKey:aName];
        }
        [arrayBlock addObject:block];
    }
}

-(void)sendNotifiMessage:(NSString *)aName notifiInfo:(void (^)(targetObj *, __autoreleasing id *))infoBlock
{
    id response = nil;
    NSMutableArray *array = [self.keyBlockDictionary objectForKey:aName];
    targetObj *obj = nil;
    if (infoBlock) {
        obj = [targetObj new];
        infoBlock(obj, &response);
    }
    for (void (^block)(targetObj *, __autoreleasing id ) in array) {
        if (block) {
            block(obj,response);
        }
    }
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
