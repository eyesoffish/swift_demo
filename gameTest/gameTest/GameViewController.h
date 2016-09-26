//
//  GameViewController.h
//  gameTest
//

//  Copyright (c) 2016年 fengei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
@interface GameViewController : UIViewController
@property (nonatomic,strong) NSString *airport;
@property (nonatomic,assign) monserSizeModel monsterSize;//妖怪大小
@end
