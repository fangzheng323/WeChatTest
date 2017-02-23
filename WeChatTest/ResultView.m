//
//  ResultView.m
//  WeChatTest
//
//  Created by 方正 on 2017/2/21.
//  Copyright © 2017年 fang. All rights reserved.
//

#import "ResultView.h"

#define Width self.bounds.size.width
#define Hegiht self.bounds.size.height
#define Basic 50

@implementation ResultView

/*
- (void)drawRect:(CGRect)rect {
}
*/
- (void)createCoordinateWith:(NSArray *)x
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //圆点
    CGPoint rPoint = CGPointMake(Basic, Hegiht-Basic);
    //y
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(Basic, 100)];
    
    [path moveToPoint:CGPointMake(Basic, 100)];
    [path addLineToPoint:CGPointMake(Basic-5, 100+5)];
    [path moveToPoint:CGPointMake(Basic, 100)];
    [path addLineToPoint:CGPointMake(Basic+5, 100+5)];
    
    //x
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(Width-30, Hegiht-Basic)];
    
    [path moveToPoint:CGPointMake(Width-30, Hegiht-Basic)];
    [path addLineToPoint:CGPointMake(Width-30-5, Hegiht-Basic-5)];
    [path moveToPoint:CGPointMake(Width-30, Hegiht-Basic)];
    [path addLineToPoint:CGPointMake(Width-30-5, Hegiht-Basic+5)];
    
    //x
    for (int i = 0; i<x.count; i++) {
        [path moveToPoint:CGPointMake(2*Basic+Basic*i, Hegiht-Basic)];
        [path addLineToPoint:CGPointMake(2*Basic+Basic*i, Hegiht-Basic-3)];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(2*Basic+Basic*i-15, Hegiht-Basic+15, 30, 20);
        lab.text = x[i];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
    //y
    for (int i = 0; i<10; i++) {
        [path moveToPoint:CGPointMake(Basic, Hegiht-Basic*2-Basic*i)];
        [path addLineToPoint:CGPointMake(Basic+3, Hegiht-Basic*2-Basic*i)];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(Basic-25, Hegiht-Basic-Basic*i-10, 25, 20);
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = [NSString stringWithFormat:@"%d",i*10];
        [self addSubview:lab];
    }
    
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 2;
    [self.layer addSublayer:layer];
}
- (void)initDrawView
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}
- (void)bingTuWithX:(NSArray*)x withY:(NSArray*)y
{
    [self initDrawView];
//    [self createCoordinateWith:x];
    CGPoint point = CGPointMake(Width/2, Hegiht/2);
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    float r = 100;
    float sum = 0;
    for (NSString *str in y) {
        sum = [str floatValue]+sum;
    }
    
    for (int i = 0; i<x.count; i++) {
        float ratio = [y[i] floatValue]/sum;
        endAngle = startAngle + ratio*2*M_PI;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path addLineToPoint:point];
        [path closePath];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor clearColor].CGColor;
        layer.fillColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor;
        [self.layer addSublayer:layer];
        
        CGFloat lab_x = point.x + (r + 25/2) * cos((startAngle + (endAngle - startAngle)/2)) - 25/2;
        CGFloat lab_y = point.y + (r + 20/2) * sin((startAngle + (endAngle - startAngle)/2)) - 20/2;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(lab_x, lab_y, 25, 20);
        lab.font = [UIFont systemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = x[i];
        [self addSubview:lab];
        startAngle = endAngle;
        
    }
}
- (void)zhuTuWithX:(NSArray*)x withY:(NSArray*)y
{
    [self initDrawView];
    [self createCoordinateWith:x];
    
    for (int i = 0; i<x.count; i++) {// 4  70
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(2*Basic+Basic*i-23, Hegiht-Basic-5*[y[i] integerValue], 0.8*Basic, 5*[y[i] integerValue])];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
    }
}
- (void)zheXianTuWithX:(NSArray*)x withY:(NSArray*)y
{
    [self initDrawView];
    [self createCoordinateWith:x];
    
    CGPoint startPoint = CGPointMake(2*Basic,Hegiht-Basic-[y[0] integerValue]*5);
    CGPoint endPoint;
    for (int i = 0; i<x.count; i++) {
        
        endPoint = CGPointMake(2*Basic+Basic*i, Hegiht-Basic- [y[i] integerValue]*5);
//        NSLog(@"endPoint==%@",NSStringFromCGPoint(endPoint));
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addArcWithCenter:endPoint radius:1.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [path addLineToPoint:endPoint];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor redColor].CGColor;
        layer.lineWidth = 1;
        [self.layer addSublayer:layer];
        
        [self drawXuxian:endPoint];
        startPoint = endPoint;
    }
    
}
//虚线
- (void)drawXuxian:(CGPoint)point{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 1;
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil]];
    
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置y轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x, Hegiht-Basic);
    
    //设置x轴方向的虚线
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, Basic, point.y);
    
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
}

@end
