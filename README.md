# ShaperlayerDemo
该Demo采用CAShapeLayer渲染view的图层，并利用UIBezierPath进行路径的绘制，最后使用了CADisplayLink进行实时的刷新界面实现了波浪动画的效果。

效果如图所示，通过UIBezierPath画出正弦曲线和余弦曲线，实现波浪的效果。底层波浪采用的是正弦曲线，上层的采用的是余弦曲线。通过改变正弦和余弦函数的初相，实现曲线沿着X轴方向移动。

![image](https://github.com/youngtian/ShaperlayerDemo/blob/master/ShaperlayerDemo/demo.png)

