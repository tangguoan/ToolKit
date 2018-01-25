//
//  RYBUrlRouter.h
//  renyibang
//
//  Created by tangguoan on 2017/3/7.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 根据url 去解析相应的部位和参数 path代表的模块   param 代表的是参数 fragment代表的是子模块
 * 可以和center配合使用
 */
@interface RYBUrlRouter : NSObject
- (instancetype)initWith:(NSString *)url;
@property(strong, nonatomic)NSString *url;

@property(strong,nonatomic, readonly)NSString *path;

@property(strong,nonatomic, readonly)NSString *host;
@property(strong,nonatomic, readonly)NSString *fragment;
@property(strong,nonatomic, readonly)NSString *query;
@property(strong,nonatomic, readonly)NSDictionary *param;

@end
