//
//  NSObject+json.m
//  ToolKit-ToolKit
//
//  Created by tangguoan on 2018/2/2.
//

#import "NSObject+JSON.h"

@implementation NSObject(json)

- (NSString *)objToJson{

    if ([self isKindOfClass:[NSString class]]) {
        return self.copy;
    }

    if ([self isKindOfClass:[NSArray class]]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:(0) error:&error];
        if (data.length && error == nil) {
            return [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)];
        }
    }

    if ([self isKindOfClass:[NSDictionary class]]) {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:(0) error:&error];
        if (data.length && error == nil) {
            return [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)];
        }
    }
    return @"";
}


- (id)jsonToObj{
    if ([self isKindOfClass:[NSString class]]) {
        NSString *tmp = (NSString *)self;
        NSData *date = [tmp dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
       id obj = [NSJSONSerialization JSONObjectWithData:date options:(NSJSONReadingAllowFragments) error:&error];
        if (error) {
            return nil;
        }
        return obj;
    }
    return nil;
}
@end
