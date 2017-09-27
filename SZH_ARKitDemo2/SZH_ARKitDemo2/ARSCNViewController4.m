//
//  ARSCNViewController4.m
//  SZH_ARKitDemo2
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ARSCNViewController4.h"

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@interface ARSCNViewController4 ()<ARSCNViewDelegate,ARSessionDelegate>

@property (nonatomic,strong) ARSCNView *arSceneView;
@property (nonatomic,strong) ARSession *arSession;
@property (nonatomic,strong) ARConfiguration *arConfiguration;
@property (nonatomic,strong) SCNNode *cutNode;

@end

@implementation ARSCNViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ----------- 点击屏幕添加模型

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self.cutNode removeFromParentNode];
    
    SCNScene *scene = [SCNScene sceneNamed:@"air.scnassets/cup/cup.scn"];
    SCNNode *planeNode = scene.rootNode.childNodes[0];
    self.cutNode = planeNode;
    planeNode.position = SCNVector3Make(0, -1, -1);
    
//    self.cutNode.position = SCNVector3Make(0, -2, -2);
    
    [self.arSceneView.scene.rootNode addChildNode:planeNode];
    
//    SCNNode *node1 = [[SCNNode alloc]init];
//    node1.position = self.arSceneView.scene.rootNode.position;
//    //将空节点添加到相机的根节点
    
    
//    [node1 addChildNode:self.cutNode];
//    
//    //旋转核心动画
//    CABasicAnimation *moonRotationAnimation = [CABasicAnimation animationWithKeyPath:@"rotation"];
//    
//    //旋转周期
//    moonRotationAnimation.duration = 30;
//    
//    //围绕Y轴旋转360度  （不明白ARKit坐标系的可以看笔者之前的文章）
//    moonRotationAnimation.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0, 1, 0, M_PI * 2)];
//    //无限旋转  重复次数为无穷大
//    moonRotationAnimation.repeatCount = FLT_MAX;
//    
//    //开始旋转  ！！！：切记这里是让空节点旋转，而不是台灯节点。  理由同上
//    [node1 addAnimation:moonRotationAnimation forKey:@"moon rotation around earth"];
}

#pragma mark ----------- ARSCNViewDelegate

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    
    
}

#pragma mark ----------- ARSessionDelegate

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    if (self.cutNode) {
//        self.cutNode.position = SCNVector3Make(frame.camera.transform.columns[3].x, frame.camera.transform.columns[3].y, frame.camera.transform.columns[3].z);
    }
}

#pragma mark ----------- 开启AR

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.arSceneView];
    [self.arSession runWithConfiguration:self.arConfiguration];
}

#pragma mark ----------- 关闭AR

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.arSession pause];
}

#pragma mark ----------- 懒加载配置环境

- (ARSCNView *)arSceneView {
    if (!_arSceneView) {
        _arSceneView = [[ARSCNView alloc]initWithFrame:self.view.bounds];
        _arSceneView.delegate = self;
        _arSceneView.session = self.arSession;
        _arSceneView.automaticallyUpdatesLighting = YES;
        
    }
    return _arSceneView;
}

- (ARSession *)arSession {
    if (!_arSession) {
        _arSession = [[ARSession alloc]init];
        _arSession.delegate = self;
    }
    return _arSession;
}

- (ARConfiguration *)arConfiguration {
    if (!_arConfiguration) {
        ARWorldTrackingConfiguration *configution = [[ARWorldTrackingConfiguration alloc]init];
        configution.planeDetection = ARPlaneDetectionHorizontal;
        _arConfiguration = configution;
        _arConfiguration.lightEstimationEnabled = YES;
    }
    return _arConfiguration;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
