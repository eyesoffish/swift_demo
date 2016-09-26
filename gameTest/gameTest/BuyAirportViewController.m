//
//  BuyAirportViewController.m
//  gameTest
//
//  Created by fengei on 16/9/22.
//  Copyright © 2016年 fengei. All rights reserved.
//

#import "BuyAirportViewController.h"
#import "LYScrollView.h"
#import "GameViewController.h"
@interface BuyAirportViewController ()<LYScrollViewDelegate>
@property (nonatomic,strong) LYScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSString *airport;
@end

@implementation BuyAirportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.airport = @"airport0.png";
    [self setupUI];
}
- (void) setupUI{
    
    self.itemArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i++) {
        [self.itemArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"airport%ld_2.png",(long)i]]];
    }
    self.scrollView = [[LYScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.itmeArray = self.itemArray;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    UIButton *btn = [self createBtn:@"开始游戏"];
    btn.tag = 100;
    btn.center = CGPointMake(self.view.center.x - 60, self.view.center.y * 2 - 60);
    
    UIButton *btn2 = [self createBtn:@"返回主页"];
    btn2.tag = 200;
    btn2.center = CGPointMake(self.view.center.x + 60, self.view.center.y * 2 - 60);
    
    [self.view addSubview:btn2];
    [self.view addSubview:btn];
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
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void) btnClick:(UIButton *)sender{
    if(sender.tag == 100)
    {
        //开始游戏
        GameViewController *gameView = [[GameViewController alloc]init];
        gameView.airport = self.airport;
        [self presentViewController:gameView animated:YES completion:nil];
    }else if(sender.tag == 200){
        //回到主页
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark --delegate
- (void)scrolIndex:(NSInteger)index
{
    self.airport = [NSString stringWithFormat:@"airport%ld.png",index];
}
@end
