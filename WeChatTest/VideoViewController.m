//
//  VideoViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/9.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>
#import <MediaPlayer/MediaPlayer.h>


#import "CustomPlayerView.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self playVideo];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor blackColor];
   
    CustomPlayerView *view = [[CustomPlayerView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width*0.75)];
    [view play];
    view.finish = ^(){
//        view.hidden = YES;
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:view];
}
//Capturing 'view' strongly in this block is likely to lead to a retain cycle
- (void)playVideo
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    
//    MPMoviePlayerViewController *move = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:file]];
//    [move.moviePlayer prepareToPlay];
//    [move.view setFrame:self.view.bounds];
//    move.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
//    [self presentMoviePlayerViewControllerAnimated:move];
    
    
    
//    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:file]];
//    
//    moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
//    [moviePlayer.view setFrame:self.view.bounds];
//    [self.view addSubview:moviePlayer.view];
//    [moviePlayer play];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:file]];
    AVPlayer * player= [[AVPlayer alloc] initWithPlayerItem:playItem];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 100, 300, 300);
    [self.view.layer addSublayer:layer];
    [player play];
}

- (void)finish
{
//    [self dismissMoviePlayerViewControllerAnimated];
}
@end
