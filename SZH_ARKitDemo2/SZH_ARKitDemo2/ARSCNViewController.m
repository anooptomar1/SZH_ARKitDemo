//
//  ARSCNViewController.m
//  SZH_ARKitDemo2
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ARSCNViewController.h"
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@interface ARSCNViewController ()

@property (nonatomic,strong) ARSCNView *arSCNView;

@property (nonatomic,strong) ARSession *arSession;

@property (nonatomic,strong) ARConfiguration *arConfiguration;

@property (nonatomic,strong) SCNNode *cupNode;

@end

@implementation ARSCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -------------- 点击屏幕添加模型

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    SCNScene *scene = [SCNScene sceneNamed:@"air.scnassets/cup/cup.scn"];
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    shipNode.position = SCNVector3Make(0, -1, -1);
    
    [self.arSCNView.scene.rootNode addChildNode:shipNode];
}


#pragma mark -------------- 开启会话

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.arSCNView];
    [self.arSession runWithConfiguration:self.arConfiguration];
}

#pragma mark -------------- 关闭会话

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.arSession pause];
}

#pragma mark -------------- 懒加载配置AR环境

- (ARSCNView *)arSCNView {
    if (!_arSCNView) {
        _arSCNView = [[ARSCNView alloc]initWithFrame:self.view.bounds];
        _arSCNView.session = self.arSession;
        _arSCNView.automaticallyUpdatesLighting = YES;
    }
    return _arSCNView;
}

- (ARSession *)arSession {
    if (!_arSession) {
        _arSession = [[ARSession alloc]init];
    }
    return _arSession;
}

- (ARConfiguration *)arConfiguration {
    if (!_arConfiguration) {
        ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc]init];
        configuration.planeDetection = ARPlaneDetectionHorizontal;
        _arConfiguration = configuration;
        _arConfiguration.lightEstimationEnabled = YES;
    }
    return _arConfiguration;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
