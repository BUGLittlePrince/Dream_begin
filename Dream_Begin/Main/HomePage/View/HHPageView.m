//
//  HHPageView.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/9.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHPageView.h"

@interface HHPageView ()<HHTitleViewDelegate, HHContentViewDelegate>

//标题数组
@property (nonatomic, strong) NSArray <NSString *> *titles;
//标题类型
@property (nonatomic, strong) HHTitleStyleLogic *style;
//子控制器数组
@property (nonatomic, strong) NSArray <UIViewController *> *childVCs;
//父控制器
@property (nonatomic, strong) UIViewController *parentVC;
//标题视图
@property (nonatomic, strong) HHTitleView *titleView;
//内容视图
@property (nonatomic, strong) HHContentView *contentView;

@end

@implementation HHPageView

- (HHPageView *)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles style:(HHTitleStyleLogic *)style childVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC
{
    if (self = [super initWithFrame:frame]) {
        NSAssert(titles.count == childVCs.count, @"标题&控制器个数不同，请检测！！！");
        self.style = style ? style : [[HHTitleStyleLogic alloc] init];
        self.titles = titles;
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        
        parentVC.automaticallyAdjustsScrollViewInsets = NO;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGFloat titleH = 44;
    CGRect titleFrame = CGRectMake(0, 0, self.frame.size.width, titleH);
    self.titleView = [[HHTitleView alloc] initWithFrame:titleFrame titles:_titles style:_style];
    self.titleView.myDelegate = self;
    [self addSubview:self.titleView];
    
    CGRect contentFrame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), self.frame.size.width, self.frame.size.height - self.titleView.frame.origin.y - self.titleView.frame.size.height);
    self.contentView = [[HHContentView alloc] initWithFrame:contentFrame childVCs:_childVCs parentViewController:_parentVC style:_style];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentView.myDelegate = self;
    [self addSubview:self.contentView];
}

#pragma mark --HHTitleViewDelegate--
- (void)titleViewWithTitleView:(HHTitleView *)titleView selectedIndex:(NSInteger)selectedIndex
{
    [self.contentView setCurrentIndex:selectedIndex];
}

#pragma mark --HHContentViewDelegate--
- (void)contentViewWith:(HHContentView *)contentView progress:(CGFloat)progress sourceIndex:(CGFloat)sourceIndex targetIndex:(CGFloat)targetIndex
{
    [self.titleView setTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

- (void)contentViewEndScrollWithContentView:(HHContentView *)contentView
{
    [self.titleView contentViewDidEndScroll];
}

@end
