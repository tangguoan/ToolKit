//
//  RYBViewController.m
//  RYBTool
//
//  Created by tangguoan on 01/05/2017.
//  Copyright (c) 2017 tangguoan. All rights reserved.
//

#import "RYBViewController.h"
#import <ToolKit.h>
#import <ToolKit/NSDate+Category.h>
@interface RYBViewController ()

@property (weak, nonatomic) IBOutlet UIButton *imageView;
@end

@implementation RYBViewController


- (void)viewDidLoad
{
    NSDate *date = [NSDate dateWithStringWithFormat:@"MM.dd" andDateString:@"10.6"];
    NSLog(@"%@",date);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
