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
#import "Stack.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import <UIView+fromNib.h>
#import "RYBeee.h"

@interface RYBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *imageView;
@property (weak, nonatomic) IBOutlet UITextField *field;
@property (strong, nonatomic) NSString *tmp;

@property( strong, nonatomic) Stack *model;
@end

@implementation RYBViewController

- (void)viewDidLoad
{
   
    [RYBeee initFromNib];
    
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
