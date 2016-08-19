//
//  ViewController.m
//  3D_Test
//
//  Created by fengei on 16/6/6.
//  Copyright © 2016年 fengei. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
@interface ViewController ()

@property (nonatomic,strong) SCNScene *scene;//存放元素节点
@property (nonatomic,strong) SCNView *sceneView;//用来展示3D图形的控件
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self myAdd];
}
- (void) myAdd
{
    self.sceneView = [[SCNView alloc]initWithFrame:self.view.bounds];
    self.sceneView.center = self.view.center;
    self.sceneView.backgroundColor = [UIColor grayColor];
    self.sceneView.allowsCameraControl = YES;
    self.sceneView.autoenablesDefaultLighting = YES;
    [self.view addSubview:self.sceneView];
    
    
    self.scene = [SCNScene scene];
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:1];
    SCNNode *node = [SCNNode nodeWithGeometry:box];
    [node addAnimation:[self getBasiAnimation] forKey:@"slide right"];
    
    //添加一个环境光
    SCNNode *nodeLight = [SCNNode node];
    nodeLight.light = [SCNLight light];
    nodeLight.light.type = SCNLightTypeAmbient;
    nodeLight.light.color = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    //增加一个副光
    SCNNode *nodeLight2 = [SCNNode node];
    nodeLight2.light = [SCNLight light];
    nodeLight2.light.type = SCNLightTypeOmni;//像各方向发出的光照强度一样
    /*
     SCNLightTypeDirectional 平行光
     SCNLightTypeSpot   聚焦光
     */
    nodeLight2.light.color = [UIColor colorWithWhite:0.75 alpha:1];
    nodeLight2.position = SCNVector3Make(0, 50, 50);//在这个盒子的上前方
    
    //添加摄像机节点
    SCNNode *nodeCarema = [SCNNode node];
    nodeCarema.camera = [SCNCamera camera];
    nodeCarema.position = SCNVector3Make(0, 0, 50);
    
    [self.scene.rootNode addChildNode:nodeCarema]; //添加摄像机
//    [self.scene.rootNode addChildNode:nodeLight2]; //添加环境副光
    [self.scene.rootNode addChildNode:nodeLight];//添加环境光
    [self.scene.rootNode addChildNode:node];// 添加正方体
//    [self.scene.rootNode addChildNode:[self AddFunction]];//将创建的原子节点添加到根节点
    self.sceneView.scene = self.scene;
    
//    SCNScene *sceneName = [SCNScene sceneNamed:@"wind tuibine100.dae"];//添加3位图片
//    self.sceneView.scene = sceneName;
}
//动画
- (CABasicAnimation *) getBasiAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.byValue = @10;
    animation.duration = 1.0;
    return animation;
}
//创建四个原子
- (SCNGeometry *) carbonAtom
{
    SCNSphere *phere = [SCNSphere sphereWithRadius:1.7];
    phere.firstMaterial.diffuse.contents = [UIColor darkGrayColor];
    phere.firstMaterial.specular.contents = [UIColor whiteColor];
    return phere;
}
- (SCNGeometry *) hydrogenAtom
{
    SCNSphere *phere = [SCNSphere sphereWithRadius:1.2];
    phere.firstMaterial.diffuse.contents = [UIColor lightGrayColor];
    phere.firstMaterial.specular.contents = [UIColor whiteColor];
    return phere;
}
- (SCNGeometry *) oxyGenAtom
{
    SCNSphere *phere = [SCNSphere sphereWithRadius:1.52];
    phere.firstMaterial.diffuse.contents = [UIColor redColor];
    phere.firstMaterial.specular.contents = [UIColor whiteColor];
    return phere;
}
- (SCNGeometry *) fluorAtom
{
    SCNSphere *phere = [SCNSphere sphereWithRadius:1.47];
    phere.firstMaterial.diffuse.contents = [UIColor yellowColor];
    phere.firstMaterial.specular.contents = [UIColor whiteColor];
    return phere;
}
//将每一个原子添加到节点
- (SCNNode *) AddFunction
{
    SCNNode *tempNode = [SCNNode node];
    
    SCNNode *carbonNode = [SCNNode nodeWithGeometry:[self carbonAtom]];
    SCNNode *hydrogenNode = [SCNNode nodeWithGeometry:[self hydrogenAtom]];
    SCNNode *oxygenNode = [SCNNode nodeWithGeometry:[self oxyGenAtom]];
    SCNNode *fluorNode = [SCNNode nodeWithGeometry:[self fluorAtom]];
    
    carbonNode.position = SCNVector3Make(-6, 0, 0);
    hydrogenNode.position = SCNVector3Make(-2, 0, 0);
    oxygenNode.position = SCNVector3Make(2, 0, 0);
    fluorNode.position = SCNVector3Make(6, 0, 0);
    
    [tempNode addChildNode:carbonNode];
    [tempNode addChildNode:hydrogenNode];
    [tempNode addChildNode:oxygenNode];
    [tempNode addChildNode:fluorNode];
    return tempNode;
}
@end
