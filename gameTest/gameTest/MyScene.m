//
//  MyScene.m
//  gameTest
//
//  Created by fengei on 16/9/20.
//  Copyright © 2016年 fengei. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()<SKPhysicsContactDelegate>
{
    int count;
}
@property (nonatomic) SKSpriteNode * airport;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimer *timer;
@end
static const uint32_t bulletCategory = 0x1 << 0;
static const uint32_t monsterCategory = 0x1 << 1;
static const uint32_t airportCategory = 0x1 << 2;
BOOL isBegin = YES;

@implementation MyScene

- (id) initWithSize:(CGSize)size airportName:(NSString *)airportName
{
    if(airportName == nil){
        airportName = @"airport0.png";
    }
    if(self = [super initWithSize:size])
    {
        //注意所有未知是以左下角为原点
        //创建飞机只需要使用spreteNOdeWithImageNamed方法，并把一幅图传递进去就可以创建一个精灵
        self.airport = [SKSpriteNode spriteNodeWithImageNamed:airportName];
        self.airport.position = CGPointMake(self.frame.size.width / 2, 20);
        [self addChild:self.airport];
        
        //设置物理世界
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        //设置物理世界的大小
        self.airport.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.airport.size];
        //设置YES表示不受重力感应
        self.airport.physicsBody.dynamic = YES;
        //设置属性是一个位掩码（bitmask）。通过该属性可以将精灵分类
        self.airport.physicsBody.categoryBitMask = airportCategory;
        //检测和谁的碰撞 此处设置飞机和怪物之间的碰撞
        self.airport.physicsBody.contactTestBitMask = monsterCategory;
        self.airport.physicsBody.collisionBitMask = 0;
        //设置为yes能够监测到碰撞，否则直接闯过去
        self.airport.physicsBody.usesPreciseCollisionDetection = YES;
        isBegin = YES;
        [self.timer fireDate];
    }
    return self;
}
//懒加载nstimer
- (NSTimer *)timer{
    if(!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(fireToKill) userInfo:nil repeats:YES];
    }
    return _timer;
}
//获取随机颜色
- (UIColor *) getRandomColor{
    NSInteger temp = arc4random_uniform(255);
    NSInteger temp2 = arc4random_uniform(255);
    NSInteger temp3 = arc4random_uniform(255);
    return [UIColor colorWithRed:temp3/255.0 green:temp/255.0 blue:temp2/255.0 alpha:1.0];
}
//添加怪物
- (void) addMonster{
    CGSize size;
    if(self.monsterSize == monsterSimple){
        //难度一30,0-100
        size = CGSizeMake(arc4random_uniform(30), arc4random_uniform(100));
    }else if(self.monsterSize == monsterDiffcult){
        //难度二20,50-100
        size = CGSizeMake(arc4random_uniform(20), arc4random_uniform(100)+50);
    }else if (self.monsterSize == monsterFuck){
        //难度三10,50-150
        size = CGSizeMake(arc4random_uniform(20), arc4random_uniform(150)+50);
    }
    //创建怪物,难度
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithColor:[self getRandomColor] size:size];
    //计算怪物出现的位置 默认冲屏幕上方20像素出现
    int minX = 10;
    int maxX = self.frame.size.width - minX;
    int rangeX = maxX - minX;
    int actualX = (arc4random()%rangeX) + minX;
    monster.position = CGPointMake(actualX, self.frame.size.height-20);
    [self addChild:monster];
    
    int minDuration = 2.0;
    int maxDuration = 6.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random()%rangeDuration) + minDuration;
    
    //设置动作从初始位置到屏幕外边
    SKAction *actionMove = [SKAction moveTo:CGPointMake(actualX, 0) duration:actualDuration];
    //动作结束自动释放怪物
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [monster runAction:[SKAction sequence:@[actionMove,actionMoveDone]]];
    //要设置怪物大小才可以检测到碰撞
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
    monster.physicsBody.dynamic = YES;//不受重力影响
    //检测怪物和子弹的碰撞
    monster.physicsBody.categoryBitMask = monsterCategory;
    monster.physicsBody.contactTestBitMask = bulletCategory;
    monster.physicsBody.collisionBitMask = 0;
}
- (void) updateWithTimeSinceLastUPdate:(CFTimeInterval)timeSinceLast{
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 1){
        self.lastSpawnTimeInterval = 0;
        [self addMonster];
        if(count > 500)
        {
            [self addMonster];
        }
        else if(count > 1000)
        {
            [self addMonster];
        }
        else if(count > 5000)
        {
            [self addMonster];
        }
    }
}
- (void) projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster{
    //碰撞时将跑道和怪物一起移除
    [projectile removeFromParent];
    [monster removeFromParent];
    // 打中一个分数加一
    count += 5;
    [self.overdelegate getScore:count];
}
//发射子弹
- (void) fireToKill{
    //创建子弹
    SKSpriteNode *projectile = [SKSpriteNode spriteNodeWithImageNamed:@"bullet"];
    //从飞机的中间位置发射出去
    projectile.position = self.airport.position;
    
    //设置精灵对应的物体形状
    projectile.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:projectile.size.width / 2];
    //设置YES表示我们自己控制精灵运动，物理引擎不能控制
    projectile.physicsBody.dynamic = YES;
    //设置精灵的类别
    projectile.physicsBody.categoryBitMask = bulletCategory;
    //设置跟谁碰撞时会通知代理
    projectile.physicsBody.contactTestBitMask = monsterCategory;
    //collisionBitMask表示物理引擎需要处理碰撞事件，在此处不希望怪物和子弹被弹开所以为0
    projectile.physicsBody.collisionBitMask = 0;
    // 设置YES能够检测到碰撞，否者直接穿过去
    projectile.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:projectile];
    
    float velocity = 480.0 / 1.0;
    float realMoveDuration = self.size.width / velocity;
    //让炮弹直接射出x不变。y为屏幕最上方
    SKAction *actionMove = [SKAction moveTo:CGPointMake(projectile.position.x, self.frame.size.height) duration:realMoveDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [projectile runAction:[SKAction sequence:@[actionMove,actionMoveDone]]];
}
#pragma mark --  自带的方法
//检测碰撞
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    //判断两个物体碰撞
    SKPhysicsBody *firstBody,*secondBody;
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if((firstBody.categoryBitMask & bulletCategory) != 0 && (secondBody.categoryBitMask & monsterCategory) != 0){
        SKSpriteNode *monster = (SKSpriteNode *)secondBody.node;
        monster.position=CGPointMake(monster.position.x, monster.position.y - 50);
        monster.size = CGSizeMake(monster.size.width, monster.size.height - 10);
        [(SKSpriteNode *)firstBody.node removeFromParent];
        count++;
        [self.overdelegate getScore:count];
        if(monster.size.height < 10)
        {
            //子弹和怪物碰撞
            [self projectile:(SKSpriteNode *)firstBody.node didCollideWithMonster:monster];
        }
    }
    else if((firstBody.categoryBitMask & monsterCategory) != 0 && (secondBody.categoryBitMask & airportCategory) != 0){
        isBegin = NO;
        [self.timer invalidate];
        self.timer = nil;
        [firstBody.node removeFromParent];
        [secondBody.node removeFromParent];
        //代理通知vc游戏结束，移除动画场景
        [self.overdelegate gameOver:self];
    }
}
- (void) update:(NSTimeInterval)currentTime
{
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1){
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    [self updateWithTimeSinceLastUPdate:timeSinceLast];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!isBegin)
    {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if(location.x < self.airport.size.width / 2){
        //不让飞机跑道屏幕外边去
        location.x = self.airport.size.width / 2;
    }else if(location.x > self.frame.size.width - self.airport.size.width/2){
        //不让飞机跑道右边屏幕外边
        location.x = self.frame.size.width - self.airport.size.width / 2;
    }
    self.airport.position = CGPointMake(location.x, self.airport.position.y);
//    [self fireToKill];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
