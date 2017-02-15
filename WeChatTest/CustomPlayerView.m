//
//  CustomPlayerView.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/9.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "CustomPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import <MediaPlayer/MediaPlayer.h>
@interface CustomPlayerView()
@property (nonatomic,strong) AVPlayerLayer *playLayer;
@property (nonatomic,strong) AVPlayer * player;
@property (nonatomic,strong) AVPlayerItem *playItem;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *time1;
@property (nonatomic,strong) UILabel *time2;
@end
@implementation CustomPlayerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
- (void)play
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    
    self.playItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:file]];
    self.player= [[AVPlayer alloc] initWithPlayerItem:self.playItem];
    
    self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playLayer.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-40);
    self.playLayer.frame = self.bounds;
//    self.playLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:self.playLayer];
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self addPlayerSubviews];
}

- (void)finishPlay
{
    if (self.finish) {
        self.finish();
    }
}

- (void)addPlayerSubviews
{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    self.topView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.topView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closePlayerView) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:closeBtn];
    
    UILabel *title = [[UILabel alloc] init];
    title.center = self.topView.center;
    title.bounds = CGRectMake(0, 0, 200, 30);
    title.text = @"title";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [self.topView addSubview:title];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
    self.bottomView.backgroundColor = [UIColor grayColor];
    UIButton *controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [controlBtn setTitle:@"暂停" forState:UIControlStateNormal];
    controlBtn.frame = CGRectMake(0, 0, 40, 40);
    [controlBtn addTarget:self action:@selector(controlPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:controlBtn];
    
    self.time1 = [[UILabel alloc] init];
    self.time1.frame = CGRectMake(40, 0, 60, 40);
    self.time1.textAlignment = NSTextAlignmentCenter;
    self.time1.textColor = [UIColor whiteColor];
    self.time1.text = @"00:00";
    [self.bottomView addSubview:self.time1];
    
    self.time2 = [[UILabel alloc] init];
    self.time2.frame = CGRectMake(self.frame.size.width-60, 0, 60, 40);
    self.time2.textAlignment = NSTextAlignmentCenter;
    self.time2.textColor = [UIColor whiteColor];
    self.time2.text = @"00:00";
    [self.bottomView addSubview:self.time2];
    
    [self addSubview:self.bottomView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timeStack)
                                   userInfo:nil
                                    repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self
                                   selector:@selector(controlToolBar)
                                   userInfo:nil
                                    repeats:YES];
}
- (void)timeStack
{
    NSInteger seconds1 = (NSInteger)CMTimeGetSeconds([self.player currentTime])/60;
    NSInteger min1 = (NSInteger)CMTimeGetSeconds([self.player currentTime])%60;
    self.time1.text = [NSString stringWithFormat:@"%02ld:%02ld",seconds1,min1];
    
    NSInteger seconds2 = (NSInteger)self.playItem.duration.value/self.playItem.duration.timescale/60;
    NSInteger min2 = (NSInteger)self.playItem.duration.value/self.playItem.duration.timescale%60;
    self.time2.text = [NSString stringWithFormat:@"%02ld:%02ld",seconds2,min2];
}
- (void)closePlayerView
{
    [self finishPlay];
}
- (void)controlPlayer:(UIButton*)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:@"播放" forState:UIControlStateNormal];
        [self.player pause];
    }else{
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.player play];
    }
}
- (void)controlToolBar 
{
    self.topView.hidden = YES;
    self.bottomView.hidden = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.topView.hidden = NO;
    self.bottomView.hidden = NO;
}
@end
