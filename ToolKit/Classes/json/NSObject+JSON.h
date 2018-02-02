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
@end
