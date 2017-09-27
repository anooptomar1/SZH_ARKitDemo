//
//  ViewController.m
//  SZH_ARKitDemo1
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ViewController.h"
#import "ARSCNViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


//开启AR
- (IBAction)szh_openARView:(id)sender {
    
    ARSCNViewController *arscnView =  [[ARSCNViewController alloc]init];
    [self presentViewController:arscnView animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
