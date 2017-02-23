//
//  WXLoginManager.h
//  WeChatTest
//
//  Created by 方正 on 2017/2/16.
//  Copyright © 2017年 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"
@interface WXLoginManager : NSObject<WXApiDelegate>
+(WXLoginManager*)shareManager;

- (void)login;
@end
