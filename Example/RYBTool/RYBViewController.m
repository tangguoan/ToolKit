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
    UILabel *la = [[UILabel alloc]init];
    la.numberOfLines = 0;
    la.backgroundColor = [UIColor yellowColor];
    la.textColor = [UIColor redColor];
    la.text = @"我是唐国安我是唐国我是唐eeeeee";
    [self.view addSubview:la];
    la.frame = CGRectMake(10, 100, 100, [la.text labelOfheightMultilineWithFont:la.font LayoutWidth:100]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
