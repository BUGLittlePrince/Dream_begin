//
//  HHPieChartView.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHPieChartView.h"

@interface HHPieChartView()<PieViewDelegate>
{
    UIView *_desView;
    UILabel *_desLbl;
}
@property (nonatomic, strong) HHPieView *pieView;
@property (nonatomic, copy) NSArray *pieArray;

@end

@implementation HHPieChartView

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray<HHPieModel *> *)array
{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.pieArray = [NSArray arrayWithArray:array];
        
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview:self.pieView];
    
    //循环添加标签
    CGFloat block_width = 30;
    CGFloat margin_space = 20;
    CGFloat margin_x = 40;
    CGFloat margin_y = 340;
    CGFloat width = (self.frame.size.width - margin_x * 2 - 3 * margin_space) / 4;
    
    for (int i = 0; i < self.pieArray.count; i++) {
        HHPieModel *model = self.pieArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(margin_x + i % 4 * (margin_space + width), margin_y + i / 4 * (margin_space + 30), block_width, block_width);
        btn.backgroundColor = model.color;
        btn.layer.cornerRadius = 5;
        btn.tag = i;
        [btn addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(btn.frame.origin.x + block_width + 2, btn.frame.origin.y, width, 30)];
        lab.text = [NSString stringWithFormat:@"%@", model.title];
        lab.textColor = [UIColor blackColor];
        [self addSubview:lab];
    }
    
    //创建说明View
    _desView = [[UIView alloc] initWithFrame:CGRectMake(margin_x, 435, self.frame.size.width -margin_x * 2, self.frame.size.height -415)];
    _desView.backgroundColor = [UIColor cyanColor];
    _desView.layer.cornerRadius = 10;
    _desView.transform = CGAffineTransformMakeTranslation(0, _desView.frame.size.height);
    [self addSubview:_desView];
    
    _desLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, _desView.frame.size.width - 40, 30)];
    _desLbl.textColor = [UIColor whiteColor];
    [_desView addSubview:_desLbl];
    
    //重置动画按钮
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(0, 0, 100, 60);
    [resetBtn setTitle:@"" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(animationReset) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetBtn];
}

- (void)animationReset
{
    [self.pieView initAnimation];
    [self removeDesview];
}

- (void)didSelect:(UIButton *)sender
{
    //选中
    [self.pieView selectAtIndex:sender.tag];
}

#pragma mark --代理方法--
- (void)pie:(HHPieView *)pieView didSelectedAtIndex:(NSInteger)index
{
    HHPieModel *model = [self.pieArray objectAtIndex:index];
    _desLbl.text = [NSString stringWithFormat:@"%@:%@ %.f个 占%.f%%", model.title, model.descript, model.count, model.percent * 100];
    [self addDesView];
}

- (void)addDesView
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _desView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)removeDesview
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _desView.transform = CGAffineTransformTranslate(_desView.transform, 0, -5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _desView.transform = CGAffineTransformTranslate(_desView.transform, 0, _desView.frame.size.height);
        } completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (CGRectContainsPoint(_desView.frame, point)) {
        [self removeDesview];
    }
}

#pragma mark --懒加载--
- (HHPieView *)pieView
{
    if (!_pieView) {
        _pieView = [[HHPieView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 150, 20, 300, 300) models:self.pieArray];
        _pieView.delegate = self;
    }
    return _pieView;
}

@end

























