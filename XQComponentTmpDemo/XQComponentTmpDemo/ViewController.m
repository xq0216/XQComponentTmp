//
//  ViewController.m
//  XQComponentTmpDemo
//
//  Created by LaiXuefei on 2018/10/8.
//  Copyright © 2018年 lxf. All rights reserved.
//

#import "ViewController.h"
#import "XQTestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //test component
    XQTestView *testView = [[XQTestView alloc]init];
    testView.frame = CGRectMake(0, 0, 100, 100);
    testView.center  = self.view.center;
    [self.view addSubview:testView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
