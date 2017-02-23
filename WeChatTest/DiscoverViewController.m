//
//  DiscoverViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/4.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "DiscoverViewController.h"
#import "VideoViewController.h"
#import "AutolayoutViewController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i =0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(100, 100+100*i, 100, 60);
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:[NSString stringWithFormat:@"btn%d",i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
}

- (void)buttonClick:(UIButton*)btn
{
    if (btn.tag==100) {
        VideoViewController *video = [[VideoViewController alloc] init];
        video.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:video animated:YES];

    }else if (btn.tag==101){
        AutolayoutViewController *layout = [[AutolayoutViewController alloc] init];
        layout.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:layout animated:YES];
    }else{
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
}

@end
