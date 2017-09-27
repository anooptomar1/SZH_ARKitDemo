//
//  ViewController.m
//  SZH_ARKitDemo2
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ViewController.h"
#import "ARSCNViewController.h"
#import "ARSCNViewController2.h"
#import "ARSCNViewController3.h"
#import "ARSCNViewController4.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



//自定义AR
- (IBAction)szh_openAR1:(id)sender {
    
    ARSCNViewController *scnView = [[ARSCNViewController alloc]init];
    [self presentViewController:scnView animated:YES completion:nil];
    
}

//捕捉平地
- (IBAction)szh_openAR2:(id)sender {
    
    ARSCNViewController2 *scnView = [[ARSCNViewController2 alloc]init];
    [self presentViewController:scnView animated:YES completion:nil];
    
}

- (IBAction)szh_openAR3:(id)sender {
    
    ARSCNViewController3 *scnView = [[ARSCNViewController3 alloc]init];
    [self presentViewController:scnView animated:YES completion:nil];
    
    
}

- (IBAction)szh_openAR4:(id)sender {
    
    
    ARSCNViewController4 *scnView = [[ARSCNViewController4 alloc]init];
    [self presentViewController:scnView animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
