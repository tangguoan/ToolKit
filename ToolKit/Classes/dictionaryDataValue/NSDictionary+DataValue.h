//
//  NSDictionary+TXDataValue.h
//  BJEducation
//
//  Created by heyingj on 11/17/15.
//  Copyright © 2015 com.bjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DataValue)

- (int)intForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (long)longForKey:(NSString *)key;
- (long long)longLongForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (long)txlongForKey:(NSString *)key;

/**
 @param key 可以带path 路径
 @return 返回array
 */
- (NSArray *)txArrayForKey:(NSString *)key;
- (NSArray *)txArrayForKey:(NSString *)key defalutValue:(NSArray *)defalutValue;;
/**
 @param key 可以带path 路径
 @return 返回array
 */
- (NSDictionary *)txDictionaryForKey:(NSString *)key;

- (NSDictionary *)txDictionaryForKey:(NSString *)key defalutValue:(NSDictionary *)defalutValue;

- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue;
- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (long)longForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long long)longLongForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue;
- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (long long )txlongForKey:(NSString *)key defaultValue:(long long )defaultValue;

@end
