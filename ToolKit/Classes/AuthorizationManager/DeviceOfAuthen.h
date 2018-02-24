//
//  AuthorizationManager.h
//  ceshi
//
//  Created by tangguoan on 2017/2/20.
//  Copyright © 2017年 tangguoan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DeviceOfAuthen: NSObject<UIAlertViewDelegate>

+(void)getAuthenPhoto:(void(^)(void))success failed:(void(^)(void))fial; //相册权限
+(void)getAuthenCamera:(void(^)(void))success failed:(void(^)(void))fial; //照相机权限
+(void)getAuthenMicrophone:(void (^)(void))success failed:(void (^)(void))fial; //麦克风权限
@end
