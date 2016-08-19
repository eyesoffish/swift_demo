//
//  MyVR_ViewController.m
//  MyVR_Test
//
//  Created by fengei on 16/6/6.
//  Copyright © 2016年 fengei. All rights reserved.
//

#import "MyVR_ViewController.h"
#import "CardboardSDK/CardboardSDK.h"

#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>
@interface MyVR_ViewController () <CBDStereoRendererDelegate>

@property (nonatomic,strong) SCNScene *scene;
@property (nonatomic,strong) SCNNode *cameraNode;
@property (nonatomic,strong) SCNNode *cameraControlNode;
@property (nonatomic,strong) SCNRenderer *renderer;
@end

@implementation MyVR_ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stereoRendererDelegate = self;
    }
    return self;
}
- (void)setupRendererWithView:(GLKView *)glView
{
    [EAGLContext setCurrentContext:glView.context];
    glClearColor(0.25f, 0.25f, 0.25f, 1.0f);
    //创建一个模型
    self.scene = [SCNScene sceneNamed:@"scene.dae"];
    self.cameraControlNode = [self.scene.rootNode childNodeWithName:@"CameraControl" recursively:YES];
    self.cameraNode = [self.scene.rootNode childNodeWithName:@"Camera" recursively:YES];
    
    SCNNode *spriteKitCube = [self.scene.rootNode childNodeWithName:@"SpriteKitCube" recursively:YES];
    spriteKitCube.geometry.firstMaterial.diffuse.contents = [[SKScene alloc]initWithSize:CGSizeMake(100, 100)];
    self.renderer = [SCNRenderer rendererWithContext:glView.context options:nil];
    self.renderer.scene = self.scene;
    self.renderer.pointOfView = self.cameraNode;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SCNAction *cameraMoveAction = [SCNAction moveTo:SCNVector3Make(-4.5, -4.5, 0) duration:10];
        cameraMoveAction.timingMode = SCNActionTimingModeEaseInEaseOut;
        [self.cameraControlNode runAction:cameraMoveAction];
    });
}
- (void)renderViewDidChangeSize:(CGSize)size
{

}
- (void)finishFrameWithViewportRect:(CGRect)viewPort
{
    
}
- (void)drawEyeWithEye:(CBDEye *)eye
{
    GLKMatrix4 lookAt = GLKMatrix4MakeLookAt(0, 0, 0, 0, 1, 0, 0, 0, 1);
    self.cameraNode.transform = SCNMatrix4Invert(SCNMatrix4FromGLKMatrix4(GLKMatrix4Multiply([eye eyeViewMatrix], lookAt)));
    [self.cameraNode.camera setProjectionTransform:SCNMatrix4FromGLKMatrix4([eye perspectiveMatrixWithZNear:0.1 zFar:100])];
    [self.renderer renderAtTime:0];
}
- (void)shutdownRendererWithView:(GLKView *)glView
{

}
- (void)prepareNewFrameWithHeadViewMatrix:(GLKMatrix4)headViewMatrix
{
    glDisable(GL_SCISSOR_TEST);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}
@end
