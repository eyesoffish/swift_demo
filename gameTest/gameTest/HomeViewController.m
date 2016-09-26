//
//  HomeViewController.m
//  gameTest
//
//  Created by fengei on 16/9/21.
//  Copyright © 2016年 fengei. All rights reserved.
//

#import "HomeViewController.h"
#import "GameViewController.h"
#import "BuyAirportViewController.h"
@interface HomeViewController ()
@property (nonatomic,strong) UIButton *btnBeginGame;
@property (nonatomic,strong) UIButton *btnBuyAirport;
@property (nonatomic,strong) UIButton *btnChooseModel;//选择难度
@property (nonatomic,strong) UIView *chooseView;
@property (nonatomic,strong) UIButton *btnClose;//关闭选择难度框
@property (nonatomic,strong) UIView *chooseModelView;//选择难度遮罩框
@property (nonatomic,assign) monserSizeModel monsetSize;//难度
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:self.btnBeginGame];
    [self.view addSubview:self.btnChooseModel];
    [self.view addSubview:self.btnBuyAirport];
    
    self.monsetSize = monsterSimple;//设置初始难度
}

#pragma mark --Getter
- (UIButton *)btnClose{
    if(!_btnClose){
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClose.frame = CGRectMake(CGRectGetMaxX(self.chooseView.frame)-45, 5, 30, 30);
        [_btnClose setTitle:@"X" forState:UIControlStateNormal];
        _btnClose.layer.cornerRadius = 15;
        _btnClose.layer.borderColor = [UIColor whiteColor].CGColor;
        _btnClose.layer.borderWidth = 1.0;
        _btnClose.layer.shadowColor = [UIColor blackColor].CGColor;
        _btnClose.layer.shadowOffset = CGSizeMake(1, 1);
        _btnClose.layer.shadowOpacity = 1.0;
        [_btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}
- (UIView *)chooseView
{
    if(!_chooseView){
        _chooseView = [[UIView alloc]init];
        _chooseView.bounds = CGRectMake(0, 0, 350, 200);
        _chooseView.center = self.view.center;
        _chooseView.layer.cornerRadius = 10;
        _chooseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        UIImageView *temp1 = [self createUIimageView:@"face1"];
        UIImageView *temp2 = [self createUIimageView:@"face3"];
        UIImageView *temp3 = [self createUIimageView:@"face2"];
        
        temp1.tag = 100;
        temp2.tag = 200;
        temp3.tag = 300;
        
        temp2.center = CGPointMake(_chooseView.center.x, 100);
        temp1.center = CGPointMake(_chooseView.center.x-100,100);
        temp3.center = CGPointMake(_chooseView.center.x+100,100);
        
        [_chooseView addSubview:self.btnClose];
        [_chooseView addSubview:temp1];
        [_chooseView addSubview:temp2];
        [_chooseView addSubview:temp3];
    }
    return _chooseView;
}
- (UIButton *)btnBeginGame{
    if(!_btnBeginGame)
    {
        _btnBeginGame = [self createBtn:@"开始游戏"];
        _btnBeginGame.center = self.view.center;
        [_btnBeginGame addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBeginGame;
}
- (UIButton *)btnBuyAirport{
    if(!_btnBuyAirport)
    {
        _btnBuyAirport = [self createBtn:@"选择飞机"];
        _btnBuyAirport.center = CGPointMake(self.view.center.x, self.view.center.y+80);
        [_btnBuyAirport addTarget:self action:@selector(btnBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBuyAirport;
}
- (UIButton *)btnChooseModel{
    if(!_btnChooseModel)
    {
        _btnChooseModel = [self createBtn:@"选择难度"];
        _btnChooseModel.center = CGPointMake(self.view.center.x, self.view.center.y-80);
        [_btnChooseModel addTarget:self action:@selector(btnChooseModelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnChooseModel;
}
//创建按钮
- (UIButton *) createBtn:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 100, 50);
    btn.layer.cornerRadius = 10;
    btn.layer.shadowOffset = CGSizeMake(1, 1);
    btn.layer.shadowColor = [UIColor blackColor].CGColor;
    btn.layer.shadowOpacity = 1.0;
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20 weight:1];
    return btn;
}
- (UIImageView *) createUIimageView:(NSString *)name{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
    imageView.bounds = CGRectMake(0, 0, 60, 60);
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
    [imageView addGestureRecognizer:tap];
    return imageView;
}
#pragma mark -- 按钮点击事件
- (void) tapGestureClick:(UITapGestureRecognizer *)sender{
    [self.chooseModelView removeFromSuperview];
    
    UIImageView *imageView = (UIImageView *)sender.view;
    
    UIImageView *checkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check"]];
    checkImageView.bounds = CGRectMake(0, 0, 25, 25);
    
    self.chooseModelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    checkImageView.center = self.chooseModelView.center;
    self.chooseModelView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    [self.chooseModelView addSubview:checkImageView];
    
    [imageView addSubview:self.chooseModelView];
    
    if(imageView.tag == 100){
        //难度一30,0-100
        self.monsetSize = monsterSimple;
    }else if(imageView.tag == 200){
        //难度二20,50-100
        self.monsetSize = monsterDiffcult;
    }else if (imageView.tag == 300){
        //难度三10,50-150
        self.monsetSize = monsterFuck;
    }
}
//关闭选择按钮
- (void) btnCloseClick{
    [self.chooseView removeFromSuperview];
    self.chooseView = nil;
}
//选择难度
- (void) btnChooseModelClick:(UIButton *) sender{
    [self.view addSubview:self.chooseView];
}
//购买飞机
- (void) btnBuyClick:(UIButton *) sender{
    [self presentViewController:[[BuyAirportViewController alloc]init ] animated:YES completion:nil];
}

-(void)startGame:(UIButton *) sender{
    GameViewController *gameVC = [[GameViewController alloc]init];
    gameVC.monsterSize = self.monsetSize;
    [self presentViewController:gameVC animated:YES completion:nil];
}
@end
