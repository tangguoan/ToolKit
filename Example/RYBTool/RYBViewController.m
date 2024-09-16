
//  RYBViewController.m
//  RYBTool
//
//  Created by tangguoan on 01/05/2017.
//  Copyright (c) 2017 tangguoan. All rights reserved.
//

#import "RYBViewController.h"
#import <ToolKit.h>
#import <ToolKit/UIImage+Bundle.h>
#import <objc/runtime.h>
#import <UIButton+config.h>
#import <NSObject+JSON.h>
#import <NSDate+Category.h>
#import <UIView+finView.h>

#import <DDFileReader.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

#import <UIView+fromNib.h>

@interface RYBViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSString *tmp;

@end

@implementation RYBViewController

//#define JKIMSafe(block)\
//    if ([NSThread isMainThread]) {\
//        block();\
//      }else{\
//        dispatch_async(dispatch_get_main_queue(), block);\
//};




- (void)viewDidLoad{
    /// 每一行都分开读取
    NSString *path = [[NSBundle mainBundle]pathForResource:@"qwe" ofType:@"txt"];
    __block NSInteger idx = 0;
    DDFileReader *read = [[DDFileReader alloc]initWithFilePath:path];
    [read enumerateLinesUsingBlock:^(NSString *json, BOOL *b) {
        idx = idx + 1;
        json = [json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSLog(@"%@",json);
    }];
}


-(void)requestDoctorId:(NSString *)doctorId{
    NSURL *url = [NSURL URLWithString:@"https://imapi.abcpen.com/auth/grant"];
    //2.创建一个请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"Basic MjpmOTc1YzYxMzdjZWYwMTgxNTdlMTAxZjc2ODQzY2RlYw==" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"" forKey:@"user_name"];
    [dic setValue:@"" forKey:@"device_id"];
    [dic setValue:@"2" forKey:@"platform_id"];
    [dic setValue:doctorId forKey:@"uid"];
// {"uid":"21083CC2-25C8-429D-998A-1598348AF0C7","user_name":"我是患者","platform_id":"2","device_id":"cesi"}
    
    NSData *param = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    request.HTTPBody = param;
    request.HTTPMethod = @"POST";
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    //该方法是阻塞式的，会卡住线程
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //4.解析服务器返回的数据
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
