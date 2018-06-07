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
#import <NSDate+Category.h>
#import <UIView+finView.h>

@interface RYBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *imageView;

@end

@implementation RYBViewController

- (void)viewDidLoad
{

    UIView *wq = [[UIView alloc]init];
    for (NSInteger i = 0 ; i<17; i++) {
        UISwitch *s =  [UISwitch new];
        [wq addSubview:s];
        if (i % 3 == 0) {
            s.tag = 3;
        }
    }
    NSArray *views = [wq findTargetViewWithTag:3];
    
}


//==================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
