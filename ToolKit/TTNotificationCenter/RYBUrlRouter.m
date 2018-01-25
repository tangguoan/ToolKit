//
//  RYBUrlRouter.m
//  renyibang
//
//  Created by tangguoan on 2017/3/7.
//  Copyright © 2017年 MingYiBangOrganization. All rights reserved.
//


#import "RYBUrlRouter.h"
@interface RYBUrlRouter ()
@property(strong, nonatomic)NSURL *router;
@end

@implementation RYBUrlRouter

-(NSString *)description
{
    return [NSString stringWithFormat:@"url:%@ path:%@ host:%@ fragment:%@ query:%@ param:%@",self.url,self.path,self.host,self.fragment,self.query,self.param];
}

- (instancetype)initWith:(NSString *)url;
{
    if (self = [super init]) {
        self.router = [NSURL URLWithString:url];
        self.url = url;
    }
    return  self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    self.router = [NSURL URLWithString:url];
}

- (NSString *)path
{
    if (self.router.path.length > 0) {
        return self.router.path;
    }
    return nil;
}

- (NSString *)host
{
    if (self.router.host.length > 0) {
        return self.router.host;
    }
    return nil;
}
- (NSString *)fragment
{
    if (self.router.fragment.length > 0) {
        return self.router.fragment;
    }
    return nil;
}

- (NSString *)query
{
    if (self.router.query.length > 0) {
        return self.router.query;
    }
    return nil;
}

- (NSDictionary *)param
{
    if (self.query.length > 0) {
        return [self getParam:self.query];
    }
    return nil;
}

#pragma mark  私有方法
-(NSDictionary *)getParam:(NSString *)urlString {
    NSMutableDictionary *queryStringDictionary = [NSMutableDictionary dictionary];
    NSArray *urlComponents = [urlString componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents){
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        [queryStringDictionary setObject:value forKey:key];
    }
    return queryStringDictionary.copy;
}
@end
