//
//  NSString+filterSpaceBlank.h
//  renyibang
//
//  Created by tangguoan on 2017/8/14.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString(filterSpaceBlank)
/**
 判断文字是否全部是空格组成的
 @return YES
 */
-(BOOL)isAllSpaceBlank;

/**
 过滤掉尾部的空格后返回的文字
 @return
 */
-(NSString *)filterNewWhitespace;
@end
