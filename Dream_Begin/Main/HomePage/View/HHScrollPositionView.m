//
//  HHScrollPositionView.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/7.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHScrollPositionView.h"

@interface HHScrollPositionView ()

@property (nonatomic, strong) UIScrollView *scrollView;
//按钮下面的线
@property (nonatomic, strong) UILabel *animationLineLabel;

@end

@implementation HHScrollPositionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.titleViewWidth = 64.0;
    self.titleContentView.fixedWidth = self.titleViewWidth / 2;
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleContentView];
    self.titleContentView.indexPoint = CGPointMake(self.titleViewWidth / 2.0, self.frame.size.height);
}

- (void)setTitlesArr:(NSArray *)titlesArr
{
    _titlesArr = titlesArr;
    [self addTitleViews];
}

- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    _contentScrollView = contentScrollView;
    [_contentScrollView.panGestureRecognizer addTarget:self action:@selector(pan:)];
}

- (void)pan:(UIPanGestureRecognizer *)ges
{
    CGPoint point = [ges translationInView:self.contentScrollView];
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        case UIGestureRecognizerStateChanged:
            //此处可以绘制最大长度
            if (fabsl(point.x * 0.5) > self.titleViewWidth * 5 / 4) {
                return;
            }
            self.titleContentView.scrollX = point.x * 0.5;
            self.titleContentView.scroll = YES;
            break;
            
        case UIGestureRecognizerStateEnded:
            break;
            
        default:
            break;
    }
    //该方法在调用sizeToFit后被调用，所以可以先调用sizeToFit计算出size。然后系统自动调用drawRect:方法
    [self.titleContentView setNeedsDisplay];
}

#pragma mark --添加子控件--
- (void)addTitleViews
{
    for (int i = 0; i < _titlesArr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_titlesArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.titleContentView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            [self settitlesViewNormal:button];
        }
    }
}

- (void)titleBtnClick:(UIButton *)btn
{
    [self settitlesViewNormal:btn];
    [self layoutSubviews];
    [self resetScrollViewOffset:btn];
    if (self.contentScrollView == nil) {
        return;
    }
    [self setContentScrollOffSetByIndex:[self.titleContentView.subviews indexOfObject:btn]];
}

- (void)setContentScrollOffSetByIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(index * self.contentScrollView.bounds.size.width, 0);
    }];
}

#pragma mark --设置scrollView偏移量的逻辑--
- (void)resetScrollViewOffset:(UIButton *)btn
{
    CGPoint point = btn.center;
    CGFloat absoultX = self.scrollView.bounds.size.width / 2.0;
    if (self.scrollView.contentSize.width <= self.scrollView.bounds.size.width) {
        return;
    }
    if (point.x > absoultX && self.scrollView.contentSize.width - point.x > absoultX) {
        //判断点击的按钮的中心点x 和 scrollView的内容宽度减去按钮中心x坐标的长度都大于scrollView的一般宽度的时候，才开始想中心移动
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(point.x - absoultX, 0);
        }];
    }
    if (point.x < absoultX) {
        //判断点击按钮的中心x小于scrollView一般宽度的时候，设置scrollView 的偏移量为0
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    if (self.scrollView.contentSize.width - point.x < absoultX) {
        //判断scrollView的内容宽度减去点击按钮的中心x的距离小于scrollView一半宽度的时候，将scrollView滑动到最右边
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width, 0);
    }
}

- (void)settitlesViewNormal:(UIButton *)btn
{
    for (UIButton *btn in self.titleContentView.subviews) {
        btn.selected = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    }
    btn.selected = YES;
    [btn setTitleColor:CNavBgColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
}

- (void)resetTitleViewState:(NSInteger)index
{
    UIButton *btn = self.titleContentView.subviews[index];
    [self settitlesViewNormal:btn];
    self.titleContentView.indexPoint = btn.center;
    [self layoutSubviews];
    [self resetScrollViewOffset:btn];
}

- (UILabel *)animationLineLabel
{
    if (!_animationLineLabel) {
        _animationLineLabel = [[UILabel alloc] init];
        _animationLineLabel.backgroundColor = [UIColor colorWithRed:3 / 255.0 green:169 / 255.0 blue:224 / 255.0 alpha:1.0];
    }
    return _animationLineLabel;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (HHScrollPositionTitleContentView *)titleContentView
{
    if (!_titleContentView) {
        _titleContentView = [[HHScrollPositionTitleContentView alloc] init];
    }
    return _titleContentView;
}

-(void)layoutSubviews
{
    self.scrollView.frame = self.bounds;
    self.titleContentView.frame = CGRectMake(0, 0, self.titleViewWidth * self.titlesArr.count, self.scrollView.bounds.size.height);
    self.scrollView.contentSize = CGSizeMake(self.titleViewWidth * self.titlesArr.count, 0);
    for (int i = 0; i < self.titleContentView.subviews.count; i ++) {
        UIButton *button = self.titleContentView.subviews[i];
        button.frame = CGRectMake(i * self.titleViewWidth, 0, self.titleViewWidth, self.scrollView.bounds.size.height);
        if (button.selected) {
            if (i == 0) {
                self.titleContentView.moveLeft = NO;
            } else {
                self.titleContentView.moveLeft = YES;
            }
            
            if (i == self.titleContentView.subviews.count - 1) {
                self.titleContentView.moveRight = NO;
            } else {
                self.titleContentView.moveRight = YES;
            }
            
            self.titleContentView.indexPoint = button.center;
            [self.titleContentView setNeedsDisplay];
        }
    }
}

@end

#pragma mark --装载内容的容器类--
@implementation HHScrollPositionTitleContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollX = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    if (_scroll) {
        if (self.scrollX > 0) {
            //向左滑
            if (!self.moveLeft) {
                CGContextMoveToPoint(context, self.indexPoint.x - self.fixedWidth / 2, rect.size.height);
                CGContextAddLineToPoint(context, self.indexPoint.x + self.fixedWidth / 2, rect.size.height);
                CGContextDrawPath(context, kCGPathStroke);
                return;
            }
            CGContextMoveToPoint(context, self.indexPoint.x + self.fixedWidth / 2, rect.size.height);
            CGContextAddLineToPoint(context, self.indexPoint.x + self.scrollX, rect.size.height);
        } else {
            //向右滑
            if (!self.moveRight) {
                CGContextMoveToPoint(context, self.indexPoint.x - self.fixedWidth / 2, rect.size.height);
                CGContextAddLineToPoint(context, self.indexPoint.x + self.fixedWidth / 2, rect.size.height);
                CGContextDrawPath(context, kCGPathStroke);
                return;
            }
            CGContextMoveToPoint(context, self.indexPoint.x - self.fixedWidth / 2, rect.size.height);
            CGContextAddLineToPoint(context, self.indexPoint.x - self.scrollX, rect.size.height);
        }
    } else {
        CGContextMoveToPoint(context, self.indexPoint.x - self.fixedWidth / 2, rect.size.height);
        CGContextAddLineToPoint(context, self.indexPoint.x + self.fixedWidth / 2, rect.size.height);
    }
    CGContextDrawPath(context, kCGPathStroke);
}

@end
