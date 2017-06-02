//
//  ViewController.m
//  LisztSlideControlMenuExample
//
//  Created by Liszt on 2017/5/10.
//  Copyright © 2017年 LisztCoder. All rights reserved.
//

#import "ViewController.h"
#import "LisztSlideControlMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)barButtonAction:(UIBarButtonItem *)sender {
    UIView *menuView = [[UIView alloc] init];
    
    [[LisztSlideControlMenu defaultSlideMenu]showModal:sender.tag==0?LisztSlideControlLeft:LisztSlideControlRight controlMenu:menuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
