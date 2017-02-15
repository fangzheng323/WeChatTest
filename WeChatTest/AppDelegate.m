//
//  AppDelegate.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/4.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "AppDelegate.h"
#import "WeChatViewController.h"
#import "ContactViewController.h"
#import "DiscoverViewController.h"
#import "MyViewController.h"

#import "WXApi.h"
#import "WXApiObject.h"
@interface AppDelegate ()//<WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self loadMainView];
    
    [WXApi registerApp:@"wxb5c6a53e7fe9a808"];//wxb5c6a53e7fe9a808
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    return YES;
}

-(void)onReq:(BaseReq*)req{
    NSLog(@"onReq");
}
- (void)onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){//微信分享回调
        SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        if (messageResp.errCode == -2) {
            NSLog(@"用户取消分享");
        }
    }else if ([resp isKindOfClass:[SendAuthResp class]]){//微信登录回调
        SendAuthResp *aresp = (SendAuthResp *)resp;
        
        /*
         ErrCode ERR_OK = 0(用户同意)
         ERR_AUTH_DENIED = -4（用户拒绝授权）
         ERR_USER_CANCEL = -2（用户取消）
         code    用户换取access_token的code，仅在ErrCode为0时有效
         state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
         lang    微信客户端当前语言
         country 微信用户当前国家信息
         */
        
        NSLog(@"aresp.errCode:%d",aresp.errCode);
        
        if (aresp.errCode== 0) {
            NSLog(@"微信登录成功");
        }else if (aresp.errCode == -2){
            NSLog(@"用户取消登录");
        }
    }else if ([resp isKindOfClass:[PayResp class]]){//微信支付
        PayResp *response = (PayResp *)resp;
        NSLog(@"response.returnKey:%@",response.returnKey);
        
        if (response.errCode == WXSuccess) {
            //服务器端查询支付通知或查询API返回的结果再提示成功
            NSLog(@"微信支付成功");
        }else if (response.errCode == WXErrCodeUserCancel){
            NSLog(@"用户取消支付");
        }else{//WXErrCodeCommon
            NSLog(@"支付失败，retcode=%d",response.errCode);
        }
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options

{
    return [WXApi handleOpenURL:url delegate:self];
}


- (void)loadMainView
{
    NSMutableArray *sourceArr = [NSMutableArray new];
    NSArray *title = [NSArray arrayWithObjects:@"微信",@"通讯录",@"发现",@"我", nil];
    NSArray *viewArr = [NSArray arrayWithObjects:@"WeChatViewController",@"ContactViewController",@"DiscoverViewController",@"MyViewController", nil];
    for (NSInteger i = 0; i<4; i++) {
        
        UIViewController *view = [[NSClassFromString(viewArr[i]) alloc] init];
        view.title = title[i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
        nav.tabBarItem.image = [UIImage imageNamed:@"find"];
        [sourceArr addObject:nav];
        
    }
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = sourceArr;
    tab.selectedIndex = 0;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
