//
//  WXLoginViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/16.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "WXLoginViewController.h"
#import "WXLoginManager.h"

@interface WXLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heardImage;
@property (weak, nonatomic) IBOutlet UILabel *oneLab;
@property (weak, nonatomic) IBOutlet UILabel *twoLab;
@property (weak, nonatomic) IBOutlet UILabel *threeLab;
@property (weak, nonatomic) IBOutlet UILabel *fourLab;

@end

@implementation WXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXLoginManager *mag = [WXLoginManager shareManager];
//    [mag login];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
}
- (void)next
{
    
}


@end
