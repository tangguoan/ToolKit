//
//  NSDictionary+TXDataValue.h
//  BJEducation
//
//  Created by tangguoan on 11/18/15.
//  Copyright © 2018 com.bjhl. All rights reserved.
//

#import "NSDictionary+DataValue.h"
#import "TXDataUtil.h"

@implementation NSDictionary (DataValue)

- (int)intForKey:(NSString *)key
{
    return [self intForKey:key defaultValue:0];
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [self integerForKey:key defaultValue:0];
}

- (long)longForKey:(NSString *)key
{
    return [self longForKey:key defaultValue:0];
}

- (long long)longLongForKey:(NSString *)key
{
    return [self longLongForKey:key defaultValue:0];
}

- (float)floatForKey:(NSString *)key
{
    return [self floatForKey:key defaultValue:0.0f];
}

- (double)doubleForKey:(NSString *)key
{
    return [self doubleForKey:key defaultValue:0.0f];
}

- (BOOL)boolForKey:(NSString *)key
{
    return [self boolForKey:key defaultValue:NO];
}

- (NSString *)stringForKey:(NSString *)key
{
    return [self stringForKey:key defaultValue:@""];
}

- (long)txlongForKey:(NSString *)key
{
    return [self txlongForKey:key defaultValue:0];
}

- (NSArray *)txArrayForKey:(NSString *)key;
{
    id value = nil;
    NSRange range = [key rangeOfString:@"."];
    if (range.location == NSNotFound) {
        value = [self valueForKey:key];
        return [value isKindOfClass:[NSArray class]] ? value : nil;
    }
    value = [self valueForKeyPath:key];
    return [value isKindOfClass:[NSArray class]] ? value : nil;
}

- (NSDictionary *)txDictionaryForKey:(NSString *)key;{
    id value = nil;
    NSRange range = [key rangeOfString:@"."];
    if (range.location == NSNotFound) {
        value = [self valueForKey:key];;
        return [value isKindOfClass:[NSDictionary class]] ? value :nil;
    }
    value = [self valueForKeyPath:key];
    return [value isKindOfClass:[NSDictionary class]] ? value :nil;
}

- (NSArray *)txArrayForKey:(NSString *)key defalutValue:(NSArray *)defalutValue;
{
    id value = [self txArrayForKey:key];
    if (value == nil) {
        value = defalutValue;
    }
    return value;
}

- (NSDictionary *)txDictionaryForKey:(NSString *)key defalutValue:(NSDictionary *)defalutValue;
{
    id value = [self txDictionaryForKey:key];
    if (value == nil) {
        value = defalutValue;
    }
    return value;
}


#pragma mark -defaultValue

- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil intForObject:value defaultValue:defaultValue] : defaultValue;
}

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil integerForObject:value defaultValue:defaultValue] : defaultValue;
}

- (long)longForKey:(NSString *)key defaultValue:(long)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil longForObject:value defaultValue:defaultValue] : defaultValue;
}

- (long long)longLongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil longLongForObject:value defaultValue:defaultValue] : defaultValue;
}

- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil floatForObject:value defaultValue:defaultValue] : defaultValue;
}

- (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil doubleForObject:value defaultValue:defaultValue] : defaultValue;
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    id value = [self valueForKey:key];
    return ([value isKindOfClass:[NSValue class]]||[value isKindOfClass:[NSString class]]) ? [TXDataUtil boolForObject:value defaultValue:defaultValue] : defaultValue;
}

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *str = defaultValue;
    id value = [self valueForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        str = [TXDataUtil stringForObject:value defaultValue:defaultValue];
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        str = ([NSNull null] == value || nil == value) ? defaultValue : [value stringValue];
    }
    return str;
}

- (long long)txlongForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    return (long long)[self longLongForKey:key defaultValue:defaultValue];
}

@end
