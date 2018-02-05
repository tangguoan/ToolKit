//
//  NSObject+json.m
//  ToolKit-ToolKit
//
//  Created by tangguoan on 2018/2/2.
//

#import "NSObject+JSON.h"
#import <objc/runtime.h>
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



/*
 * 用对象转的 基本oc对象的数据
 *可以确定的是一定用字典接收, 因为对象一定有key中,没有key的数据model没有意义
 */
 + (NSDictionary*)getObjToDictionary
{
    id obj = (id)self;
    if([obj isKindOfClass:[NSString class]]|| [obj isKindOfClass:[NSNumber class]]||[obj isKindOfClass:[NSNull class]]){
        NSString *descri = [[obj class] description];
        descri = [NSString stringWithFormat:@"参数只能是自定义的数据;不能是%@",descri];
        NSAssert(NO,descri);
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *propertyArr = class_copyPropertyList([obj class], &count);
    for(int i = 0;i < count; i++){
        objc_property_t property = propertyArr[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [obj valueForKey:propName];//kvc读值
        if(value == nil){
            value = [NSNull null];
        }else{
            value = [self getContainerObj:value];   //自定义处理数组，字典, 没有对集合处理 TODO
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

//处理容器中的obj对象
- (id)getContainerObj:(id)obj
{
    //处理的是不是容器的基本的数据类型就统统返回 TODO:有没有后的方法判断是不是容器类
    if([obj isKindOfClass:[NSString class]]|| [obj isKindOfClass:[NSNumber class]]||[obj isKindOfClass:[NSNull class]]){
        return obj;
    }

    if([obj isKindOfClass:[NSArray class]]){
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray array];
        for(int i = 0;i < objarr.count; i++){
            [arr setObject:[self getContainerObj:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }

    //  处理字典的数据
    if([obj isKindOfClass:[NSDictionary class]]){
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for(NSString *key in objdic.allKeys){
            [dic setObject:[self getContainerObj:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }

    //     不是容器的话 去循环递归
    //    似乎少了NSSet 集合类的东西  TODO
    return [obj getObjToDictionary];
}


@end
