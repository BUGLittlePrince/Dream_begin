//
//  HHPieView.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHPieView.h"

@interface HHPieView()

@property (nonatomic, copy) NSMutableArray <HHPieModel *> *model_arr;
@property (nonatomic, copy) NSMutableArray *path_arr;
@property (nonatomic, strong) CABasicAnimation *animation;
//动画效果mask
@property (nonatomic, strong) CAShapeLayer *maskLayer;
//选中layer
@property (nonatomic, strong) CAShapeLayer *selectLayer;

@end

@implementation HHPieView

{
    //当前绘制百分比总和
    CGFloat currentPercent;
    //中心layer 容器
    CALayer *_contentLayer;
    
    CGFloat width;
    CGFloat radius;
    CGPoint center;
}

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray<HHPieModel *> *)array
{
    if (self = [super initWithFrame:frame]) {
        [self setupDefin];
        [self setupData:array];
        [self setupView];
        [self initAnimation];
    }
    return self;
}

- (void)reloadWithArray:(NSArray<HHPieModel *> *)array
{
    [_contentLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_contentLayer removeFromSuperlayer];
    
    _contentLayer = nil;
    _path_arr = [[NSMutableArray alloc] init];
    
    [self setupData:array];
    [self setupView];
    [self initAnimation];
}

- (void)initAnimation
{
    [self removeSelectStatus];
    [self.maskLayer removeAnimationForKey:@"starAnimation"];
    _contentLayer.mask = self.maskLayer;
    [self.maskLayer addAnimation:self.animation forKey:@"starAnimation"];
}

- (void)removeSelectStatus
{
    [self.selectLayer removeFromSuperlayer];
    self.selectLayer = nil;
}

- (void)selectAtIndex:(NSInteger)index
{
    [self didSelectedAtInt:index];
}

- (void)selectAtModel:(HHPieModel *)model
{
    if (self.model_arr && self.path_arr) {
        NSInteger index = [self.model_arr indexOfObject:model];
        [self selectAtIndex:index];
    }
}

#pragma mark --私有方法--
//自定义
- (void)setupDefin
{
    _isSelect = YES;
    _isSelectAnimation = YES;
    currentPercent = 0;
    width = self.frame.size.width;
    radius = self.frame.size.width / 2;
    center = CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2);
    _path_arr = [[NSMutableArray alloc] init];
}

//根据数据填对应的数据
- (void)setupData:(NSArray *)array
{
    _model_arr = [NSMutableArray arrayWithArray:array];
    CGFloat sumCount = 0;
    
    //计算总和
    for (HHPieModel *model in _model_arr) {
        sumCount += model.count;
    }
    
    //计算所占百分比
    for (int i = 0; i < _model_arr.count; i ++) {
        HHPieModel *model = _model_arr[i];
        CGFloat percent = model.count / sumCount;
        model.percent = percent;
    }
}

#pragma mark --添加layer视图--
- (void)setupView
{
    //扇形图
    _contentLayer = [CALayer layer];
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
    
    for (int i = 0; i < _model_arr.count; i ++) {
        HHPieModel *model = _model_arr[i];
        CGFloat star = currentPercent;
        CGFloat end = model.percent + star;
        CGFloat startAngle = -M_PI_2 + M_PI_2 * 4 * star;
        CGFloat endAngle = M_PI_2 * 4 * end - M_PI_2;
        
        //记录已绘制的百分比
        currentPercent += model.percent;
        
        //绘制
        [self createLayerWithStartAngle:startAngle endAngle:endAngle color:model.color model:model];
    }
}

//绘制方法
- (void)createLayerWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle color:(UIColor *)color model:(HHPieModel *)model
{
    //clockwise 顺时针方向
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    [path addLineToPoint:center];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = color.CGColor;
    [_contentLayer addSublayer:layer];
    [_path_arr addObject:path];
    
    //标签坐标
    float r = width / 4;
    CGFloat bLWidth = width = width / 6 + 5 >= 45 ? 40 : width / 6;
    CGFloat lab_x = center.x + (r + bLWidth / 2) * cos((startAngle + (endAngle - startAngle) / 2)) - bLWidth / 2;
    CGFloat lab_y = center.y + (r + bLWidth * 3 / 8) * sin((startAngle + (endAngle - startAngle) / 2)) - bLWidth * 3 / 8 + 3;
    
    //加字
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.frame = CGRectMake(lab_x, lab_y, bLWidth, bLWidth * 3 / 4);
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.string = [NSString stringWithFormat:@"%.f%%", model.percent * 100];
    textLayer.fontSize = width / 15;
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [_contentLayer addSublayer:textLayer];
}

#pragma mark --touchesDelegate--
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isSelect) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    //中间镂空圆范围不可点
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithArcCenter:center radius:width / 4 startAngle:M_PI_2 endAngle:M_PI_2 * 4 clockwise:YES];
    
    //遍历点击区域
    for (UIBezierPath *path in _path_arr) {
        if ([path containsPoint:point] && ![rectPath containsPoint:point]) {
            NSInteger index = [_path_arr indexOfObject:path];
            [self didSelectedAtInt:index];
            return;
        }
    }
}

- (void)didSelectedAtInt:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pie:didSelectedAtIndex:)]) {
        [self.delegate pie:self didSelectedAtIndex:index];
    }
    
    if (!self.isSelectAnimation) {
        return;
    }
    
    CGFloat sum = 0;
    if (index != 0) {
        for (int i = 0; i < index; i ++) {
            HHPieModel *model = [_model_arr objectAtIndex:i];
            sum += model.percent;
        }
    }
    HHPieModel *model = [_model_arr objectAtIndex:index];
    self.selectLayer.strokeStart = sum;
    self.selectLayer.strokeEnd = model.percent + sum;
    self.selectLayer.strokeColor = model.color.CGColor;
}

#pragma mark --懒加载--
- (CABasicAnimation *)animation
{
    if (!_animation) {
        CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        an.duration = 1;
        an.fromValue = @(0);
        an.toValue = @(1);
        an.removedOnCompletion = NO;
        an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _animation = an;
    }
    return _animation;
}

- (CAShapeLayer *)maskLayer
{
    if (!_maskLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineWidth = width - width / 5;
        _maskLayer = layer;
    }
    return _maskLayer;
}

- (CAShapeLayer *)selectLayer
{
    if (!_selectLayer) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineWidth = radius / 6;
        layer.opacity = 0.4;
        _selectLayer = layer;
        [_contentLayer insertSublayer:layer atIndex:0];
    }
    return _selectLayer;
}

@end

























