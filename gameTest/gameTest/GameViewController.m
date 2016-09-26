//
//  GameViewController.m
//  gameTest
//
//  Created by fengei on 16/9/20.
//  Copyright (c) 2016年 fengei. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()<GameOver>
{
    SKView *skView;
    UILabel *lb_score;
}
@property (nonatomic,strong) UIButton *btnShare;
@property (nonatomic,strong) UIButton *btnHome;
@end
@implementation GameViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"monsterSize = %ld",(long)self.monsterSize);
    //设置视图
    skView = [[SKView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:skView];
    //添加标签
    lb_score = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 20)];
    lb_score.text = @"分数:0";
    lb_score.font = [UIFont systemFontOfSize:15];
    lb_score.textAlignment = NSTextAlignmentCenter;
    lb_score.textColor = [UIColor redColor];
    
    
    [skView addSubview:lb_score];
    //添加scene
    if(!skView.scene){
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        //创建和设置scene
        MyScene *scene = [[MyScene alloc]initWithSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) airportName:self.airport];
        scene.monsterSize = self.monsterSize;
        scene.overdelegate = self;
        [skView presentScene:scene];
    }
}
- (UIButton *) AddMyButton:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 100, 50);
    btn.layer.cornerRadius = 10;
    btn.layer.shadowOffset = CGSizeMake(1, 1);
    btn.layer.shadowColor = [UIColor blackColor].CGColor;
    btn.layer.shadowOpacity = 1.0;
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void) start:(UIButton *) sender{
    if(sender.tag == 100)
    {
        [_btnShare removeFromSuperview];
        [_btnHome removeFromSuperview];
        [sender removeFromSuperview];
        //创建和设置scene
        MyScene *scene = [[MyScene alloc]initWithSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) airportName:self.airport];
        scene.overdelegate = self;
        scene.monsterSize = self.monsterSize;
        lb_score.text = @"分数: 0";
        [skView presentScene:scene];
    }else if(sender.tag == 200){ //分享
        
    }else if(sender.tag == 300){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark --GameOver
- (void)gameOver:(SKScene *)scene
{
    [scene removeFromParent];
    scene = nil;
    
    UIButton *btn = [self AddMyButton:@"重新开始"];
    btn.center = self.view.center;
    btn.tag = 100;
    
    UIButton *btn2 = [self AddMyButton:@"炫耀一下"];
    btn2.center = CGPointMake(self.view.center.x, self.view.center.y+80);
    btn2.tag = 200;
    _btnShare = btn2;
    
    UIButton *btn3 = [self AddMyButton:@"回到主页"];
    btn3.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    btn3.tag = 300;
    _btnHome = btn3;
    
    [skView addSubview:btn];
    [skView addSubview:btn2];
    [skView addSubview:btn3];
}

- (void)getScore:(int)score
{
    lb_score.text = [NSString stringWithFormat:@"分数: %d",score];
    [UIView animateWithDuration:0.3 animations:^{
        lb_score.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        lb_score.transform = CGAffineTransformIdentity;
        lb_score.layer.borderColor = [UIColor whiteColor].CGColor;
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
