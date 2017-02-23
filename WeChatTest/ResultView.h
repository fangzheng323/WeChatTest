//
//  ResultView.h
//  WeChatTest
//
//  Created by 方正 on 2017/2/21.
//  Copyright © 2017年 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UITime) {
    
    time1 = 0,
    time2 = 1,
    time3,
    time4,
};

@interface ResultView : UIView
- (void)createCoordinateWith:(NSArray *)x;
- (void)zhuTuWithX:(NSArray*)x withY:(NSArray*)y;
- (void)zheXianTuWithX:(NSArray*)x withY:(NSArray*)y;
- (void)bingTuWithX:(NSArray*)x withY:(NSArray*)y;
@end
