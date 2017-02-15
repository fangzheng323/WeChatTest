//
//  ContactViewController.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/4.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()
@property (nonatomic,strong) UIView *redView;
@property (nonatomic) CGPoint beginPoint;
@property (nonatomic,assign) float distanceOld;
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.redView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.multipleTouchEnabled = YES;
    [self.view addSubview:self.redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    UITouch *touch =[touches anyObject];
    CGPoint point = [touch locationInView:self.redView];
//    NSLog(@"%f %f",point.x,point.y);
    
    self.redView.layer.anchorPoint = CGPointMake(point.x/self.redView.frame.size.width, point.y/self.redView.frame.size.height);
    self.redView.center = [touch locationInView:self.view];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch =[touches anyObject];
    
    if ([touch.view isEqual:self.view]) {
        return;
    }
    
    self.redView.center = [touch locationInView:self.view];
    
    CGPoint point = self.redView.center;
    
    if (self.redView.center.x<(self.redView.frame.size.width/2)) {
        point.x = self.redView.frame.size.width/2;
    }else if (self.redView.center.x>(self.view.frame.size.width - (self.redView.frame.size.width/2))){
        point.x = self.view.frame.size.width - (self.redView.frame.size.width/2);
    }
    
    if (self.redView.center.y<(self.redView.frame.size.height/2)) {
        point.y = self.redView.frame.size.height/2;
    }else if (self.redView.center.y>(self.view.frame.size.height - (self.redView.frame.size.height/2))){
        point.y = self.view.frame.size.height - (self.redView.frame.size.height/2);
    }
    self.redView.center = point;
    
    if ([touches count]==2) {
        
        NSArray *arr = [touches allObjects];
        
        UITouch *touch1 = arr[0];
        UITouch *touch2 = arr[1];
        
        CGPoint point1 = [touch1 locationInView:self.redView];
        CGPoint point2 = [touch2 locationInView:self.redView];
        
        float dis = [self getDistanceWith:point1 point2:point2];
        if (self.distanceOld!=0) {
            float disNew = dis - self.distanceOld;
            
            CGRect rect = self.redView.frame;
            rect.origin.x = rect.origin.x + disNew/2;
            rect.origin.y = rect.origin.y +disNew/2;
            
            rect.size.width = rect.size.width + disNew;
            rect.size.height = rect.size.height + disNew;
            
            self.redView.frame = rect;
        }
        self.distanceOld = dis;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.distanceOld = 0;
}
- (float)getDistanceWith:(CGPoint)point1 point2:(CGPoint)point2
{
    float x = point1.x - point2.x;
    float y = point1.y - point2.y;
    
    float dis = sqrt (x*x + (y*y));
    return dis;
}
@end
