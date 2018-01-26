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

@property (weak, nonatomic) IBOutlet UIButton *imageView;
@end

@implementation RYBViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.ttTitle = @"仁医邦";
    self.imageView.ttTitleColor = [UIColor redColor];
    self.imageView.ttFont = [UIFont systemFontOfSize:50];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
