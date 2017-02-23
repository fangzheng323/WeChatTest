//
//  DrawViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/21.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "DrawViewController.h"
#import "ResultView.h"
@interface DrawViewController ()

@property (nonatomic,strong) ResultView *drawview;
@property (nonatomic,strong) NSArray *xArr,*yArr;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.xArr = [NSArray arrayWithObjects:@"北京",@"上海",@"深圳",@"杭州",@"苏州", nil];
    self.yArr = [NSArray arrayWithObjects:@"50",@"70",@"60",@"30",@"70",nil];
    self.drawview = [[ResultView alloc] initWithFrame:self.view.bounds];
    self.drawview
    .backgroundColor =[UIColor lightGrayColor];
    [self.drawview createCoordinateWith:self.xArr];
//    [self.drawview zheXianTuWithX:self.xArr withY:self.yArr];
//    [self.drawview zhuTuWithX:self.xArr withY:self.yArr];
//    [self.drawview bingTuWithX:self.xArr withY:self.yArr];
    [self.view addSubview:self.drawview];
    
//    [self performSelector:@selector(zheXian) withObject:nil afterDelay:1];
    NSArray *array = [NSArray arrayWithObjects:@"折线图",@"柱状图",@"饼形图", nil];
    for (int i=0; i<array.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(60+100*i, 100, 80, 30);
        button.tag = 100+i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)buttonClick:(UIButton*)button
{
    if (button.tag==100) {
        [self.drawview zheXianTuWithX:self.xArr withY:self.yArr];
    }else if (button.tag==101){
        [self.drawview zhuTuWithX:self.xArr withY:self.yArr];
    }else{
        [self.drawview bingTuWithX:self.xArr withY:self.yArr];
    }
}
- (void)zheXian
{
    [self.drawview zheXianTuWithX:self.xArr withY:self.yArr];
    [self performSelector:@selector(zhuTu) withObject:nil afterDelay:1];
}
- (void)zhuTu
{
    [self.drawview zhuTuWithX:self.xArr withY:self.yArr];
    [self performSelector:@selector(bingTu) withObject:nil afterDelay:1];
}
- (void)bingTu
{
    [self.drawview bingTuWithX:self.xArr withY:self.yArr];
    [self performSelector:@selector(zheXian) withObject:nil afterDelay:1];
}
@end
