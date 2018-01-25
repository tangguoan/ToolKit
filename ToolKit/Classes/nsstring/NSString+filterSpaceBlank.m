//
//  NSString+filterSpaceBlank.m
//  renyibang
//
//  Created by tangguoan on 2017/8/14.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//

#import "NSString+filterSpaceBlank.h"

@implementation NSString(filterSpaceBlank)

- (BOOL)isAllSpaceBlank{
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        return YES;
    }
    return NO;
}

- (NSString *)filterNewWhitespace{
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
