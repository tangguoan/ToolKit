//
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
#import <PureLayout.h>
#import <NSString+figure.h>
#import <NSObject+json.h>
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

- (void)viewDidLoad{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"qwe" ofType:@"txt"];
    __block NSInteger idx = 0;
    DDFileReader *read = [[DDFileReader alloc]initWithFilePath:path];
    
    
    [read enumerateLinesUsingBlock:^(NSString *json, BOOL *b) {
        idx = idx + 1;
        json = [json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [self request:json];
        NSLog(@"序列%ld  用户id:%@", idx,json);
        
    }];
    
    
    
    return;
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"我是唐国安"];
            NSError *err = [NSError errorWithDomain:@"eeeee" code:345 userInfo:@{}];
            [subscriber sendError:err];
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    
    
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"%@", x);
    }];
    [command execute:@1];
    
    

    
    
    
    
    
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
        
    }];
}



-(void)request:(NSString *)doctor_id{

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
    [dic setValue:doctor_id forKey:@"uid"];
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
    NSLog(@"%@",str);
    NSLog(@"错误的信息:%@",error);
    if (error) {
        exit(0);
    }
}

-(void)nihao{
//    NSLog(@"%@",self.model.name);
//    self.model.name = @"tangguoan";
}

#pragma mark - dddd
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
