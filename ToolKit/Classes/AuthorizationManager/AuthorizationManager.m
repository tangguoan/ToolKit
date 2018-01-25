//
//  AuthorizationManager.m
//  ceshi
//
//  Created by tangguoan on 2017/2/20.
//  Copyright © 2017年 tangguoan. All rights reserved.
//

#import "AuthorizationManager.h"
#import <PhotosUI/PhotosUI.h>
#import "ReactiveCocoa.h"
#import "SVProgressHUD.h"
@implementation AuthorizationManager

+ (void)okPhoto:(void (^)())success failed:(void (^)())fial
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusNotDetermined ) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:@"是否获取权限,否则无法使用相册照片" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
        [alter.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
            if (x.integerValue == 0) {
                //                if (fial) {
                //                    fial();
                //                }
                [SVProgressHUD showInfoWithStatus:@"请允许获取相册权限"];
            }else{
                PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    if (status == PHAuthorizationStatusAuthorized) {
                        NSLog(@"-------去请求权限并成功-------");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (success) {
                                success();
                            }
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (fial) {
                                fial();
                            }
                        });
                    }
                }];
            }
            
        }];
        [alter show];
    }
    if ((authStatus == PHAuthorizationStatusRestricted) || (authStatus == PHAuthorizationStatusDenied)) {
        [SVProgressHUD showInfoWithStatus:@"请到设置里获取相册权限"];
        if (fial) {
            fial();
        }
    }
    
    if (authStatus == PHAuthorizationStatusAuthorized) {
        if (success) {
            success();
        }
    }
}

+ (void)okCamera:(void (^)())success failed:(void (^)())fial
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == PHAuthorizationStatusNotDetermined ) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:@"是否获取权限,否则无法使用照相机" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
        [alter.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
            if (x.integerValue == 0) {
                //                if (fial) {
                //                    fial();
                //                }
                [SVProgressHUD showInfoWithStatus:@"请允许获取照相机权限"];
            }else{
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted && success) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       success();
                   });
                    }else if(granted == NO &&fial){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            fial();
                        });
                    }
                }];
            }
        }];
        [alter show];
    }
    if ((authStatus == PHAuthorizationStatusRestricted) || (authStatus == PHAuthorizationStatusDenied)) {
        if (fial) {
            fial();
        }
    }
    
    if (authStatus == PHAuthorizationStatusAuthorized) {
        if (success) {
            success();
        }
        NSLog(@"已经获取权限");
    }    
}

+ (void)okMicrophone:(void (^)())success failed:(void (^)())fial
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == PHAuthorizationStatusNotDetermined) {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:@"是否获取权限,否则无法使用相应的功能" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
        [alter.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
            if (x.integerValue == 0) {
                if (fial) {
                    fial();
                }
            }else{
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted && success) {
                            success();
                        }
                        if (granted == NO && fial) {
                            fial();
                        }
                    });
                }];
            }
        }];
        [alter show];

        return;
    }
    if ((authStatus == PHAuthorizationStatusRestricted) || (authStatus == PHAuthorizationStatusDenied)) {
        if (fial) {
            fial();
        }
    }
    if (authStatus == PHAuthorizationStatusAuthorized) {
        if (success) {
            success();
        }
    }
}

@end
