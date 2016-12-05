//
//  WaveView.m
//  ShaperlayerDemo
//
//  Created by tianyaxu on 16/12/2.
//  Copyright © 2016年 tianyaxu. All rights reserved.
//

#import "WaveView.h"

@interface WaveView()
{
    CAShapeLayer *_waveLayer1;
    CAShapeLayer *_waveLayer2;
    
    CADisplayLink *_disPlayLink;

    CGFloat _waveAmplitude; //曲线的振幅
    CGFloat _wavePalstance; //曲线角速度
    CGFloat _waveX; //曲线初相
    CGFloat _waveY; //曲线偏距
    CGFloat _waveMoveSpeed; //曲线移动速度
}

@property (nonatomic, strong) CADisplayLink *displayLick;

@end

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createShaperLayer];
    }
    return self;
}

- (void)createShaperLayer {
    
    //底层波浪Layer
    _waveLayer1 = [CAShapeLayer layer];
    _waveLayer1.fillColor = [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1].CGColor;
    [self.layer addSublayer:_waveLayer1];
    
    //上层波浪Layer
    _waveLayer2 = [CAShapeLayer layer];
    _waveLayer2.fillColor = [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1].CGColor;
    [self.layer addSublayer:_waveLayer2];
    
    _waveAmplitude = 10; //振幅
    _wavePalstance = M_PI / self.bounds.size.width; //角速度
    _waveY = self.bounds.size.height * 0.1; //偏距
    _waveX = 0; //初相
    _waveMoveSpeed = _wavePalstance * 10; //X轴移动速度
    _displayLick = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [_displayLick addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateWave:(CADisplayLink *)link {
    _waveX += _waveMoveSpeed;
    
    _waveLayer2.path = [self setCurrentFirstWavelayerPath:2].CGPath;
    _waveLayer1.path = [self setCurrentFirstWavelayerPath:1].CGPath;
}

//构建正弦余弦曲线路径
- (UIBezierPath *)setCurrentFirstWavelayerPath:(NSInteger)type {
    UIBezierPath *wavePath = [[UIBezierPath alloc] init];
    CGFloat y = _waveY;
    for (NSInteger x = 0.0f; x <= self.bounds.size.width; x ++) {
        if (type == 1) {
            //正弦曲线
            y = _waveAmplitude * sinf(_wavePalstance * x + _waveX) + _waveY;
        } else {
            //余弦曲线
            y = _waveAmplitude * cosf(_wavePalstance * x + _waveX) + _waveY;
        }
        
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    [wavePath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    return wavePath;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
