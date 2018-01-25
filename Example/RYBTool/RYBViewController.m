//
//  RYBViewController.m
//  RYBTool
//
//  Created by tangguoan on 01/05/2017.
//  Copyright (c) 2017 tangguoan. All rights reserved.
//

#import "RYBViewController.h"
#import <ToolKit.h>
@interface RYBViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation RYBViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [[TTNotificationCenter shareInstace]addObserveNotifi:@"qwe" notifiBlock:^(targetObj *target, id response) {
        NSLog(@"1");
    }];
    [[TTNotificationCenter shareInstace]addObserveNotifi:@"qwe" notifiBlock:^(targetObj *target, id response) {
        NSLog(@"2");
    }];
    [[TTNotificationCenter shareInstace]addObserveNotifi:@"qwe" notifiBlock:^(targetObj *target, id response) {
        NSLog(@"3");
    }];

    [[TTNotificationCenter shareInstace]sendNotifiMessage:@"qwe" notifiInfo:^(targetObj *target, __autoreleasing id *response) {
        *response = @"we";
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
