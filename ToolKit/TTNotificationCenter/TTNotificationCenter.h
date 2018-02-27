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

/***
 *1创建此类的目的是为了 减少使用系统的通知忘记移除而引起的崩溃
 *2此类更容易传递各种参数
 *3需要在同一个线程中使用,避免出现异常问题
 *4模仿系统的通知
*/

@interface TTNotificationCenter : NSObject
+(instancetype)shareInstace;

/**
 *  obj 的block 会对里面的self和其他值进行强引用
 */
-(void)addObserverNotifi:(id)observer name:(NSString *)aName notifiBlock:(void(^)(targetObj *target, id response))obj;
-(void)sendNotifiName:(NSString *)aName notifiInfo:(void(^)(targetObj *target, id *response))obj;
//删除要移除对应的block
-(void)ttDelete:(id)observer;

@end
