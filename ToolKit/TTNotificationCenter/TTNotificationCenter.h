//
//  TGANotificationBlock.h
//  TGANotifacation
//
//  Created by 唐--逍遥 on 2016/11/21.
//  Copyright © 2016年 唐--逍遥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class RYBUrlRouter;

@interface targetObj : NSObject

/**
 管理当前视图的导航器
 */
@property(nonatomic ,strong) UINavigationController *na;

/**
 由那个控制器跳到另外的控制器  也可以传递控制器数据
 */
@property(nonatomic ,strong) UIViewController *vc;

/**
  用来区别哪一个targetObj
 */
@property(nonatomic ,strong) id key;

/**
 可以传进去路由的信息
 */
@property(nonatomic ,strong) RYBUrlRouter *router;

@end


@interface TTNotificationCenter : NSObject
+(instancetype)shareInstace;

- (void)addObserveNotifi:(NSString *)aName  notifiBlock:(void(^)(targetObj *target, id response))block;

-(void)sendNotifiMessage:(NSString *)aName notifiInfo:(void(^)(targetObj *target, id *response))infoBlock;

@end
