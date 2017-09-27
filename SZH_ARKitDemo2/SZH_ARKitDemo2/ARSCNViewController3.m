//
//  ARSCNViewController3.m
//  SZH_ARKitDemo2
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ARSCNViewController3.h"

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@interface ARSCNViewController3 ()<ARSessionDelegate,ARSCNViewDelegate>

@property (nonatomic,strong) ARSCNView *arSceneview;

@property (nonatomic,strong) ARSession *arSession;

@property (nonatomic,strong) ARConfiguration *arConfiguration;

@property (nonatomic,strong) SCNNode *cutNode;
@end

@implementation ARSCNViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ----------- 点击屏幕添加模型

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SCNScene *scene = [SCNScene sceneNamed:@"air.scnassets/cup/cup.scn"];
    
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    self.cutNode = shipNode;
//    shipNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
    shipNode.position = SCNVector3Make(0, -1,-1);
    
    //一个飞机的3D建模不是一气呵成的，可能会有很多个子节点拼接，所以里面的子节点也要一起改，否则上面的修改会无效
    for (SCNNode *node in shipNode.childNodes) {
//        node.scale = SCNVector3Make(0.5, 0.5, 0.5);
        node.position = SCNVector3Make(0, -1,-1);
    }
    
    [self.arSceneview.scene.rootNode addChildNode:shipNode];
    
}

#pragma mark ----------- ARSCNViewDelegate

- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
        SCNBox *plane = [SCNBox boxWithWidth:planeAnchor.extent.x * 0.3 height:planeAnchor.extent.x * 0.3 length:planeAnchor.extent.x * 0.3 chamferRadius:0];
        plane.firstMaterial.diffuse.contents = [UIColor redColor];
        SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
        planeNode.position = SCNVector3Make(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z);
        [node addChildNode:planeNode];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            SCNScene *scene = [SCNScene sceneNamed:@""];
            SCNNode *planeNode = scene.rootNode.childNodes[0];
            planeNode.position = SCNVector3Make(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z);
            
            [node addChildNode:planeNode];
        });
    }
}

#pragma mark ----------- ARSessionDelegate

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    
    if (self.cutNode) {
        self.cutNode.position = SCNVector3Make(frame.camera.transform.columns[3].x, frame.camera.transform.columns[3].y, frame.camera.transform.columns[3].z);
    }
}


#pragma mark ----------- 开启AR

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.arSceneview];
    [self.arSession runWithConfiguration:self.arConfiguration];
}

#pragma mark ----------- 关闭AR

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.arSession pause];
}

#pragma mark ----------- 懒加载搭建环境

- (ARSCNView *)arSceneview {
    if (!_arSceneview) {
        _arSceneview = [[ARSCNView alloc]initWithFrame:self.view.bounds];
        _arSceneview.delegate = self;
        _arSceneview.session = self.arSession;
        _arSceneview.automaticallyUpdatesLighting = YES;
    }
    return _arSceneview;
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
