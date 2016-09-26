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
//monsterModel
typedef NS_ENUM(NSInteger){
    monsterSimple,
    monsterDiffcult,
    monsterFuck
}monserSizeModel;
@interface MyScene : SKScene

@property (nonatomic,weak) id<GameOver> overdelegate;
- (id) initWithSize:(CGSize)size airportName:(NSString *)airportName;
@property (nonatomic,assign) monserSizeModel monsterSize;// 妖怪大小
@end
