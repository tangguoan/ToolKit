//
//  TXDataUtil.h
//  BJEducation
//
//  Created by heyingj on 11/10/15.
//  Copyright © 2015 com.bjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXDataUtil : NSObject

+ (id)nilIfNull:(id)object;
+ (int)intForObject:(id)object;
+ (NSInteger)integerForObject:(id)object;
+ (long)longForObject:(id)object;
+ (long long)longLongForObject:(id)object;
+ (float)floatForObject:(id)object;
+ (double)doubleForObject:(id)object;
+ (BOOL)boolForObject:(id)object;
+ (NSString *)stringForObject:(id)object;

+ (int)intForObject:(id)object defaultValue:(int)defaultValue;
+ (NSInteger)integerForObject:(id)object defaultValue:(NSInteger)defaultValue;
+ (long)longForObject:(id)object defaultValue:(long)defaultValue;
+ (long long)longLongForObject:(id)object defaultValue:(long long)defaultValue;
+ (float)floatForObject:(id)object defaultValue:(float)defaultValue;
+ (double)doubleForObject:(id)object defaultValue:(double)defaultValue;
+ (BOOL)boolForObject:(id)object defaultValue:(BOOL)defaultValue;
+ (NSString *)stringForObject:(id)object defaultValue:(NSString *)defaultValue;

@end
