//
//  TXDataUtil.m
//  BJEducation
//
//  Created by heyingj on 11/10/15.
//  Copyright © 2015 com.bjhl. All rights reserved.
//

#import "TXDataUtil.h"

@implementation TXDataUtil

+ (BOOL)isNull:(id)object
{
    return ([NSNull null] == object || nil == object);
}

+ (id)nilIfNull:(id)object
{
    return ([NSNull null] == object) ? nil : object;
}

+ (int)intForObject:(id)object
{
    return [[self class] intForObject:object defaultValue:0];
}

+ (NSInteger)integerForObject:(id)object
{
    return [[self class] integerForObject:object defaultValue:0];
}

+ (long)longForObject:(id)object
{
    return [[self class] longForObject:object defaultValue:0];
}

+ (long long)longLongForObject:(id)object
{
    return [[self class] longLongForObject:object defaultValue:0];
}

+ (float)floatForObject:(id)object
{
    return [[self class] longLongForObject:object defaultValue:0.0f];
}

+ (double)doubleForObject:(id)object
{
    return [[self class] longLongForObject:object defaultValue:0.0f];
}

+ (BOOL)boolForObject:(id)object
{
    return [[self class] boolForObject:object defaultValue:NO];
}

+ (NSString *)stringForObject:(id)object
{
    return [[self class] stringForObject:object defaultValue:nil];
}

#pragma mark -defaultValue

+ (int)intForObject:(id)object defaultValue:(int)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : [object intValue];
}

+ (NSInteger)integerForObject:(id)object defaultValue:(NSInteger)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : [object integerValue];
}

+ (long)longForObject:(id)object defaultValue:(long)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : (long)[object longLongValue];
}

+ (long long)longLongForObject:(id)object defaultValue:(long long)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : [object longLongValue];
}

+ (float)floatForObject:(id)object defaultValue:(float)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : [object floatValue];
}

+ (double)doubleForObject:(id)object defaultValue:(double)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : [object doubleValue];
}

+ (BOOL)boolForObject:(id)object defaultValue:(BOOL)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : [object boolValue];
}

+ (NSString *)stringForObject:(id)object defaultValue:(NSString *)defaultValue
{
    return [[self class] isNull:object] ? defaultValue : object;
}

@end
