//
//  ViewController.m
//  ShaperlayerDemo
//
//  Created by tianyaxu on 16/12/2.
//  Copyright © 2016年 tianyaxu. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

typedef NS_ENUM(NSInteger, YDWavePathType) {
    YDWavePathType_Sin,
    YDWavePathType_Cos
};

@interface ViewController ()

@property (nonatomic, assign) CGFloat frequency;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveWid;
@property (nonatomic, assign) CGFloat macAmplitude;
@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign) CGFloat phase;

@property (nonatomic, strong) CAShapeLayer *waveSinLayer;
@property (nonatomic, strong) CAShapeLayer *waveConLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self drawMethod1];
    WaveView *waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 200)];
    [self.view addSubview:waveView];
}

//画火柴人的方法
- (void)drawMethod1 {
    //创建绘图的路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    //绘制上部到圆形图
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.strokeColor = [UIColor colorWithRed:147 / 255.0 green:231 / 255.0 blue:182 / 255.0 alpha:1].CGColor;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.lineWidth = 5; //设置线宽
    shaperLayer.lineJoin = kCALineJoinRound; //线条间集合点的样子
    shaperLayer.lineCap = kCALineCapRound; //线条结尾的样子
    shaperLayer.path = path.CGPath;
    [self.view.layer addSublayer:shaperLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
