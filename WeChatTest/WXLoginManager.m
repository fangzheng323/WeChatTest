//
//  WXLoginManager.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/16.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "WXLoginManager.h"

@implementation WXLoginManager
+(WXLoginManager*)shareManager
{
    static WXLoginManager *mag;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mag = [[WXLoginManager alloc] init];
    });
    return mag;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registWX];
    }
    return self;
}
- (void)registWX
{
    [WXApi registerApp:@"wxb5c6a53e7fe9a808" enableMTA:YES];
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
}
-(void) onReq:(BaseReq*)req
{
    
}
-(void) onResp:(BaseResp*)resp
{
    
}

- (void)login
{
    SendAuthReq *req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"0744" ;
    BOOL suess = [WXApi sendReq:req];
    if (suess == YES) {
        NSLog(@"suess");
    }
    
}
@end
