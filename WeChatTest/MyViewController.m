//
//  MyViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/4.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "MyViewController.h"

#import "WXApi.h"
#import "WXApiObject.h"
#import "WXLoginViewController.h"
#import "WXLoginManager.h"

@interface MyViewController ()<WXApiDelegate>
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [WXLoginManager shareManager];
    for (NSInteger i = 0; i<3; i++) {
        
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(100, 100+100*i, 100, 50);
        payBtn.backgroundColor = [UIColor yellowColor];
        payBtn.tag = i+1;
        [payBtn addTarget:self action:@selector(goToWX:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:payBtn];
    }
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"q",@"w",@"e",@"r",@"d",@"f",nil];
    id obj;
    NSEnumerator *enumer = [array1 reverseObjectEnumerator];//倒序reverseObjectEnumerator 顺序objectEnumerator
    while (obj = [enumer nextObject]) {
        NSLog(@"obj == %@",obj);
    }
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    CGRect rect1 = CGRectMake(0, 0, 10, 10);
    NSValue *value1 = [NSValue valueWithCGRect:rect1];
    [array2 addObject:value1];
    CGRect rect2 = CGRectMake(10, 10, 101, 101);
    NSValue *value2 = [NSValue value:&rect2 withObjCType:@encode(CGRect)];
    [array2 addObject:value2];
    NSLog(@"array2 == %@",array2);
    
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(220, 220, 100, 50)];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = @"123";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor greenColor];
    //text.inputAccessoryView = view;
    text.inputView = view;
    [self.view addSubview:text];
    
    //UIColor *color = [UIColor colorWithPatternImage:<#(nonnull UIImage *)#>]
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)goToWX:(UIButton*)btn
{
    
    if (btn.tag == 1) {
        
//        NSURL *url = [NSURL URLWithString:@"weixin://"];
//        if([[UIApplication sharedApplication] canOpenURL:url]){
//            [[UIApplication sharedApplication] openURL:url options:[NSDictionary new] completionHandler:^(BOOL success) {
//                NSLog(@"yes");
//                self.view.backgroundColor = [UIColor redColor];
//            }];
//        }else{
//            NSLog(@"没有装微信");
//        }
        [self WXShare];
    }else if (btn.tag == 2){
        
        WXLoginViewController *login = [[WXLoginViewController alloc] init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }else{
        
        [self doAnimation];
            
        btn.userInteractionEnabled  = NO;
    }
}

- (void)WXShare
{
    WXMediaMessage *message2 = [WXMediaMessage message];
    message2.title = @"This is weChat test !";
    message2.description = @"Text";
    [message2 setThumbImage:[UIImage imageNamed:@"find@2x.png"]];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = @"https://github.com/fangzheng323";
    message2.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message2;
    
    
    
//    [WXApi sendReq:req];
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.text = @"This is weixin test !";
//    req.bText = YES;
    req.scene = WXSceneTimeline;
    BOOL isOk = [WXApi sendReq:req];
    if (isOk==YES) {
        NSLog(@"suess");
    }else{
        
    }
}
-(void)onReq:(BaseReq*)req
{
    
}
- (void)WXPay
{
    //需要创建这个支付对象
    PayReq *req = [[PayReq alloc] init];
    //应用id
    req.openID = @"";
    
    // 商家商户号
    req.partnerId = @"";
    
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId = @"";//self.orderWithWX.prepayid;
    
    // 根据财付通文档填写的数据和签名
    //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
    req.package = @"Sign=WXPay";
    
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr = @"";//self.orderWithWX.noncestr;
    
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = @"";//self.orderWithWX.timestamp;
    req.timeStamp = stamp.intValue;
    
    // 这个签名也是后台做的
    req.sign = @"";//self.orderWithWX.sign;
    
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];

}

- (void)doAnimation
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-130, 100, 100, 100)];
    image.image = [UIImage imageNamed:@"lkbubble1.jpg"];
    image.tag = 100;
    [self.view addSubview:image];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAnimation) userInfo:nil repeats:YES];

}
- (void)moveAnimation
{
    static int count = 1;
    UIImageView *image = (UIImageView*)[self.view viewWithTag:100];
    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"lkbubble%d.jpg",count%8+1]];
    count++;
}
- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}
@end
