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

- (void)setupSubViews {
    self.waveSinLayer = [[CAShapeLayer alloc] init];
    self.waveSinLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.waveSinLayer.fillColor = [UIColor greenColor].CGColor;
    self.waveSinLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 20);
    
    self.waveConLayer = [[CAShapeLayer alloc] init];
    self.waveConLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.waveConLayer.fillColor = [UIColor blueColor].CGColor;
    self.waveConLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 20);
    
    self.waveHeight = 100;
    self.waveWidth = self.view.bounds.size.width;
    self.frequency = 0.3;
    self.phaseShift = 8;
    self.waveWid = self.waveWidth / 2.0;
    self.macAmplitude = self.waveHeight * 0.3;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    view1.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view1];
    
 
    
    view1.layer.mask = self.waveSinLayer;
    //view2.layer.mask = self.waveConLayer;
}

- (void)startLoading {
    if (self.displayLink) {
        [self.displayLink invalidate];
    }
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    CGPoint position = self.waveSinLayer.position;
    position.y = position.y - 19;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.waveSinLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration = 5;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.waveSinLayer addAnimation:animation forKey:@"positionWave"];
   // [self.waveConLayer addAnimation:animation forKey:@"positionWave"];
}

- (void)stopLoading {
    [self.displayLink invalidate];
    [self.waveSinLayer removeAllAnimations];
    [self.waveConLayer removeAllAnimations];
    self.waveConLayer.path = nil;
    self.waveSinLayer.path = nil;
}

- (void)updateWave:(CADisplayLink *)displayLink {
    self.phase += self.phaseShift;
    self.waveConLayer.path = [self createSinPath:YDWavePathType_Cos].CGPath;
    self.waveSinLayer.path = [self createSinPath:YDWavePathType_Sin].CGPath;
}

- (UIBezierPath *)createSinPath:(YDWavePathType)pathType {
    UIBezierPath *sinPath = [[UIBezierPath alloc] init];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x ++) {
        endX = x;
        CGFloat y = 0;
        if (pathType == YDWavePathType_Sin) {
            y = self.macAmplitude * sinf(360.0 / self.waveWidth * (x * M_PI / 180) * self.frequency + self.phase * M_PI / 180) + self.macAmplitude;
        } else {
            y = self.macAmplitude * cosf(360.0 / self.waveWidth * (x * M_PI / 180) * self.frequency + self.phase * M_PI / 180) + self.macAmplitude;
        }
        
        if (x == 0) {
            [sinPath moveToPoint: CGPointMake(x, y)];
        } else {
            [sinPath addLineToPoint:CGPointMake(x, y)];
        }
    }
    CGFloat endY = 21;
    [sinPath addLineToPoint:CGPointMake(endX, endY)];
    [sinPath addLineToPoint:CGPointMake(0, endX)];
    return sinPath;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
