//
//  MyScene.h
//  gameTest
//
//  Created by fengei on 16/9/20.
//  Copyright © 2016年 fengei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameOver <NSObject>

- (void) gameOver:(SKScene *)scene;
- (void) getScore:(int)score;

@end
@interface MyScene : SKScene

@property (nonatomic,weak) id<GameOver> overdelegate;
@end
