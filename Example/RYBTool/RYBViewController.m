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
//#import <UIButton+config.h>
#import <PureLayout.h>
#import <NSString+figure.h>
#import <NSObject+json.h>
#import "Persion.h"
@interface RYBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *imageView;

@end

@implementation RYBViewController

- (void)viewDidLoad
{

    NSMutableArray * arr = [NSMutableArray array];
    for (NSInteger i =0; i<5; i++) {
        Persion *p = [Persion new];
        [p setValue:@(i) forKey:@"height"];
        p.name = @"唐国安";
        [arr addObject:p];
    }
    Persion *p = [Persion new];
    p.name = @"中国人";
    p.students = arr;
    NSLog(@"%@",[p getObjToDictionary]);
}

//==================

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
