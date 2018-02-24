//
//  NSObject+json.h
//  ToolKit-ToolKit
//
//  Created by tangguoan on 2018/2/2.
//

#import <Foundation/Foundation.h>

@interface NSObject(json)

/*
 * 返回的是字符串
 * 穿进去的是对象
 */
-(NSString *)objToJson;

/*
 * json 转化成对象
 */
-(id)jsonToObj;

/*
 * 用对象转的 基本oc对象的数据
 *可以确定的是一定用字典接收, 因为对象一定有key中,没有key的数据model没有意义
 */
- (NSDictionary *)getObjToDictionary;
@end
