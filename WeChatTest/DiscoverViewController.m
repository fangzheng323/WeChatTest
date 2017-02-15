//
//  DiscoverViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/4.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "DiscoverViewController.h"
#import "VideoViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    VideoViewController *video = [[VideoViewController alloc] init];
    video.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:video animated:YES];
}

@end
