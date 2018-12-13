//
//  HHRootNavigationController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHRootNavigationController.h"
#import "HHTransition.h"
#import "HHXYTransitionProtocol.h"

@interface HHRootNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) id popDelegate;
//在手势的监听方法中计算手势移动的百分比
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
//手势的可接受的起始边缘
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popRecognizer;
//是否开启系统右滑返回
@property (nonatomic, assign) BOOL isSystemSlidBack;

@end

@implementation HHRootNavigationController

//APP生命周期中，只会执行一次
+ (void)initialize
{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
//    [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [navBar setBarTintColor:CNavBgColor];
    [navBar setTintColor:CNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:CNavBgFontColor, NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
    [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //去掉阴影线
    [navBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    //默认开启系统右滑返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    //只有在使用转场动画的时候，禁止系统手势，开启自定义右滑手势
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    //全屏返回
//    _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    
    //从左边开始拖动
    _popRecognizer.edges = UIRectEdgeLeft;
    [_popRecognizer setEnabled:NO];
    [self.view addGestureRecognizer:_popRecognizer];
}

#pragma mark --解决手势失效问题--
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    } else {
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

#pragma mark -- 根据视图禁用右滑返回 --
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count == 1 ? NO : YES;
}

#pragma mark -- push时隐藏tabbar --
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        if ([viewController conformsToProtocol:@protocol(HHXYTransitionProtocol)] && [self isNeedTransition:viewController]) {
            viewController.hidesBottomBarWhenPushed = NO;
        } else {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    
    [super pushViewController:viewController animated:animated];
    //修改tabBar的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[HHRootViewController class]]) {
        HHRootViewController *vc = (HHRootViewController*)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            vc.view.top = kTopHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

#pragma mark -- 返回到指定的类视图 --
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if (vc != nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    return NO;
}

/**
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图名称
 *
 *  @return 成功返回对应的对象，失败返回nil
 */
- (instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray *szArray = self.viewControllers;
    for (id vc in szArray) {
        /**
            1.isKindOfClass用来判断某个对象是否属于某个类，或者是属于某个派生类。
            2.isMemberOfClass用来判断某个对象是否为当前类的实例。
            PS:isMemberOfClass不能检测任何的类都是基于NSObject类这一事实，而isKindOfClass可以。
         */
        if ([vc isMemberOfClass:classObj]) {
            return vc;
        }
    }
    return nil;
}

//顶部状态栏样式啊：设置启动画面和视图中的状态栏颜色都为白色
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

#pragma mark -- 转场动画区 --
//navigation切换是会走这个代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    HHLog(@"转场动画代理方法");
    self.isSystemSlidBack = YES;
    //如果来源VC和目标VC都实现协议，那么都做动画
    if ([fromVC conformsToProtocol:@protocol(HHXYTransitionProtocol)] && [toVC conformsToProtocol:@protocol(HHXYTransitionProtocol)]) {
        BOOL pinterestNeed = [self isNeedTransition:fromVC :toVC];
        HHTransition *transion = [HHTransition new];
        if (operation == UINavigationControllerOperationPush && pinterestNeed) {
            transion.isPush = YES;
            //暂时屏蔽带动画的右滑返回
            self.isSystemSlidBack = NO;
        } else if (operation == UINavigationControllerOperationPop && pinterestNeed) {
            //暂时屏蔽带动画的右滑返回
            transion.isPush = NO;
            self.isSystemSlidBack = NO;
        } else {
            return nil;
        }
        return transion;
    } else if ([toVC conformsToProtocol:@protocol(HHXYTransitionProtocol)]) {
        //如果只有目标VC开启动画，那么isSystemSlidBack也要随之改变
        BOOL pinterestNeed = [self isNeedTransition:toVC];
        self.isSystemSlidBack = !pinterestNeed;
        return nil;
    }
    return nil;
}

#pragma mark -- 判断fromVC 和 toVC 是否需要实现pinterest效果 --
- (BOOL)isNeedTransition:(UIViewController<HHXYTransitionProtocol> *)fromVC :(UIViewController<HHXYTransitionProtocol> *)toVC
{
    BOOL a = NO;
    BOOL b = NO;
    if ([fromVC respondsToSelector:@selector(isNeedTransition)] && [fromVC isNeedTransition]) {
        a = YES;
    }
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return (a & b);
}

- (BOOL)isNeedTransition:(UIViewController<HHXYTransitionProtocol> *)toVC
{
    BOOL b = NO;
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return b;
}

#pragma mark -- NavigationControllerDelegate --
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (!self.interactivePopTransition) {
        return nil;
    }
    return self.interactivePopTransition;
}

#pragma mark -- UIGestureRecognizer handlers --
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    HHLog(@"右滑progress %.2f", progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        /**
            translationInView : 手指在视图上移动的位置（x,y）向下和向右为正，向上和向左为负。
            locationInView ： 手指在视图上的位置（x,y）就是手指在视图本身坐标系的位置。
            velocityInView： 手指在视图上移动的速度（x,y）, 正负也是代表方向，值得一体的是在绝对值上|x| > |y| 水平移动， |y|>|x| 竖直移动。
         */
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        if (progress > 0.5 || velocity.x > 100) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
