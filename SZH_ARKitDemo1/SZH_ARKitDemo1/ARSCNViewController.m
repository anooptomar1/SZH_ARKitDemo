//
//  ARSCNViewController.m
//  SZH_ARKitDemo1
//
//  Created by 智衡宋 on 2017/9/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ARSCNViewController.h"
//先导入SceneKit(3D游戏框架)
#import <SceneKit/SceneKit.h>
//后导入ARKit框架
#import <ARKit/ARKit.h>

@interface ARSCNViewController ()

//AR视图：展示3D界面
@property (nonatomic,strong)ARSCNView *arSCNView;
//AR会话，负责管理相机追踪配置及3D相机的运动
@property (nonatomic,strong)ARSession *arSession;
//会话追踪配置,负责追踪相机的运动
@property (nonatomic,strong)ARConfiguration *arConfiguration;
//飞机3D模型
@property (nonatomic,strong)SCNNode *planeNode;

@end

@implementation ARSCNViewController


#pragma mark ------------ 开启AR扫描

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //将AR视图添加到当前视图
    [self.view addSubview:self.arSCNView];
    //开启AR会话
    [self.arSession runWithConfiguration:self.arConfiguration];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //关闭AR会话
    [self.arSession pause];
}


#pragma mark ------------ 点击屏幕添加飞机

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //使用场景加载scn文件（scn格式文件是一个基于3D建模的文件，使用3DMax软件可以创建，这里系统有一个默认的3D飞机）
    SCNScene *scene = [SCNScene sceneNamed:@"air.scnassets/cup/cup.scn"];
    //获取节点（一个场景会有多个节点，此处我们只写，飞机节点则默认是场景子节点的第一个）
    //所有的场景有且只有一个根节点，其他所有节点都是根节点的子节点
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    //椅子比较大，可以可以调整Z轴的位置让它离摄像头远一点，，然后再往下一点（椅子太高我们坐不上去）就可以看得全局一点
    shipNode.position = SCNVector3Make(0, -1, -1);
    
    //将节点添加到当前屏幕上
    [self.arSCNView.scene.rootNode addChildNode:shipNode];
    
}


#pragma mark ------------


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
}


#pragma mark ------------ 搭建AR环境

//懒加载会话追踪配置
- (ARConfiguration *)arConfiguration {
    
    if (!_arConfiguration) {
        //创建世界追踪会话配置（使用ARWorldTrackingConfiguration效果更加好），需要A9芯片支持
        ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc]init];
        //设置追踪方向（追踪平面，后面会用到）
        configuration.planeDetection = ARPlaneDetectionHorizontal;
        _arConfiguration = configuration;
        //自适应灯光
        _arConfiguration.lightEstimationEnabled = YES;
        
    }
    return _arConfiguration;
}


//懒加载拍摄会话
-  (ARSession *)arSession {
    if (!_arSession) {
        _arSession = [[ARSession alloc]init];
    }
    return _arSession;
}


//懒加载AR视图
- (ARSCNView *)arSCNView {
    if (!_arSCNView) {
        //创建AR视图
        _arSCNView = [[ARSCNView alloc]initWithFrame:self.view.bounds];
        //设置视图会话
        _arSCNView.session = self.arSession;
        //自动刷新灯光
        _arSCNView.automaticallyUpdatesLighting = YES;
    }
    return _arSCNView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
