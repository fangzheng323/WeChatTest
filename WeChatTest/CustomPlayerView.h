//
//  CustomPlayerView.h
//  WeChatTest
//
//  Created by 方正 on 2017/2/9.
//  Copyright © 2017年 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Finish)();
@interface CustomPlayerView : UIView

@property (nonatomic,copy) Finish finish;
- (void)play;
@end
