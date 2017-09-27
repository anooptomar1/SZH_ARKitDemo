//
//  ARSCNViewController2.m
//  SZH_ARKitDemo2
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ARSCNViewController2.h"
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@interface ARSCNViewController2 ()<ARSCNViewDelegate,ARSessionDelegate>

@property (nonatomic,strong) ARSCNView *arScnview;

@property (nonatomic,strong) ARSession *arSession;

@property (nonatomic,strong) ARConfiguration *arConfiguration;

@property (nonatomic,strong) SCNNode *cupNode;

@end

@implementation ARSCNViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark --------------- ARSCNViewDelegate

//添加节点时候调用（当开启平地捕捉模式之后，如果捕捉到平地，ARKit会自动添加一个平地节点）
- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(nonnull SCNNode *)node forAnchor:(nonnull ARAnchor *)anchor {
    
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        NSLog(@"捕捉到平地");
        //1.获取捕捉到的平地锚点
        ARPlaneAnchor *planeARchor = (ARPlaneAnchor *)anchor;
        //2.创建一个3D物体模型    （系统捕捉到的平地是一个不规则大小的长方形，这里笔者将其变成一个长方形，并且是否对平地做了一个缩放效果）
//        SCNBox *plane = [SCNBox boxWithWidth:planeARchor.extent.x * 0.3 height:planeARchor.extent.x * 0.3 length:planeARchor.extent.x * 0.3 chamferRadius:0];
//
//        //3.使用Material渲染3D模型（默认模型是白色的，这里笔者改成红色）
//        plane.firstMaterial.diffuse.contents = [UIColor redColor];
//
//        //4.创建一个基于3D物体模型的节点
//        SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
//        //5.设置节点的位置为捕捉到的平地的锚点的中心位置  SceneKit框架中节点的位置position是一个基于3D坐标系的矢量坐标SCNVector3Make
//        planeNode.position = SCNVector3Make(planeARchor.center.x, planeARchor.center.y, planeARchor.center.z);
//        [node addChildNode:planeNode];
        
        
        //2.当捕捉到平地时，2s之后开始在平地上添加一个3D模型
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            SCNScene *scene = [SCNScene sceneNamed:@"air.scnassets/cup/cup.scn"];
            SCNNode *vaseNode = scene.rootNode.childNodes[0];
            
            vaseNode.position = SCNVector3Make(planeARchor.center.x, planeARchor.center.y, planeARchor.center.z);
            

            
            [node addChildNode:vaseNode];
            
        });
        
    }
   
}

//刷新时调用
- (void)renderer:(id<SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    NSLog(@"刷新中");
}

//更新节点时掉用
- (void)renderer:(id<SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"节点更新");
}

//移除节点时调用
- (void)renderer:(id<SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
     NSLog(@"节点移除");
}


#pragma mark --------------- ARSessionDelegate

//会话位置更新（监听相机的移动），此代理方法会调用非常频繁，只要相机移动就会调用，如果相机移动过快，会有一定的误差，具体的需要强大的算法去优化，笔者这里就不深入了
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    
    NSLog(@"相机移动");
}

- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor *> *)anchors {
    
    NSLog(@"添加锚点");
    
}

- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor *> *)anchors {
    
    NSLog(@"移除锚点");
}

#pragma mark --------------- 开启AR

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.arScnview];
    [self.arSession runWithConfiguration:self.arConfiguration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.arSession pause];
}

#pragma mark --------------- 懒加载搭建AR环境

- (ARSCNView *)arScnview {
    if (!_arScnview) {
        _arScnview = [[ARSCNView alloc]initWithFrame:self.view.bounds];
        _arScnview.session = self.arSession;
        _arScnview.delegate = self;
        _arScnview.automaticallyUpdatesLighting = YES;
    }
    return _arScnview;
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
        configuration.lightEstimationEnabled = YES;
        self.arConfiguration = configuration;
    }
    return _arConfiguration;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
