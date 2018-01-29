//
//  AuthorizationManager.h
//  ceshi
//
//  Created by tangguoan on 2017/2/20.
//  Copyright © 2017年 tangguoan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AuthorizationManager : NSObject<UIAlertViewDelegate>

+(void)okPhoto:(void(^)())success failed:(void(^)())fial; //相册权限
+(void)okCamera:(void(^)())success failed:(void(^)())fial; //照相机权限
+ (void)okMicrophone:(void (^)())success failed:(void (^)())fial; //麦克风权限
@end
