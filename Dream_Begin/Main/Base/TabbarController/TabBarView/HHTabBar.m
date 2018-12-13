//
//  HHTabBar.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

/**
    如果你想让一个控件的生命周期随着你的控制器被销毁才去释放，那就使用strong；如果你仅仅是想让它在被移除之后就被销毁，那就使用weak
 */

#import "HHTabBar.h"
#import "UIBarButtonItem+HHExtension.h"

@interface HHTabBar ()

@property (nonatomic, assign) UIEdgeInsets oldSafeAreaInsets;
@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation HHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_plus"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_plus"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_add"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

//点击加号按钮
- (void)plusBtnClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.myDelegate tabBarDidClickPlusButton:self];
    }
}

//重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    //设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置x
            child.hh_x = tabBarButtonIndex * tabBarButtonW;
            //设置宽度
            child.hh_width = tabBarButtonW;
            //增加索引
            tabBarButtonIndex ++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex ++;
            }
        }
    }
}

//做iPhoneX及其以后机型的适配
- (void)safeAreaInsetsDidChange
{
    [super safeAreaInsetsDidChange];
    if (self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
        self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
        self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
        self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom)
    {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        //自动计算尺寸
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize s = [super sizeThatFits:size];
    if (@available(iOS 11.0, *)) {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if (bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}

@end
