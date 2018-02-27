//
//  otherViewController.m
//  RYBTool_Example
//
//  Created by tangguoan on 2018/2/27.
//  Copyright © 2018年 tangguoan. All rights reserved.
//

#import "otherViewController.h"
#import <TTNotificationCenter.h>
@interface otherViewController ()
@property (strong, nonatomic)NSString *name;
@end

@implementation otherViewController


- (void)dealloc{

    NSLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//    __weak otherViewController *nihoa = self;
    [[TTNotificationCenter shareInstace] addObserverNotifi:self name:@"qwe" notifiBlock:^(targetObj *target, id response) {
        self.name = @"";
        NSLog(@"测试 测试 %@",response);

    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[TTNotificationCenter shareInstace]sendNotifiName:@"qwe" notifiInfo:^(targetObj *target, __autoreleasing id *response) {

            *response = @"我是返回值";

        }];
    });


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[TTNotificationCenter shareInstace]ttDelete:self];
    });


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [btn setTitle:@"按钮" forState:0];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 60, 70);
    [btn addTarget:self action:@selector(ceshi) forControlEvents:UIControlEventTouchUpInside];

}


-(void)ceshi
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
