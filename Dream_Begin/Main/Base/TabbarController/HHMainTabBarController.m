//
//  HHMainTabBarController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHMainTabBarController.h"
#import "HHHomeBaseViewController.h"
#import "HHHomePageViewController.h"
#import "HHDataPageViewController.h"
#import "HHVideoViewController.h"
#import "HHMineViewController.h"
#import "HHRootNavigationController.h"
#import "UITabBar+HHCustomBadge.h"
#import "HHTabBar.h"
#import "HHPlusViewController.h"

@interface HHMainTabBarController ()<UITabBarControllerDelegate, HHTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *VCS;

@end

@implementation HHMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    //初始化tabbar
    [self setupTabBar];
    //添加自控制器
    [self setupAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark -- 初始化tabBar --
- (void)setupTabBar
{
    //设置背景色,去掉分割线
    HHTabBar *tab = [[HHTabBar alloc] init];
    tab.myDelegate = self;
    [self setValue:tab forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
}

#pragma mark -- 初始化VC --
- (void)setupAllChildViewController
{
    _VCS = @[].mutableCopy;
    
    HHHomeBaseViewController *homeVC = [[HHHomeBaseViewController alloc] init];
    [self setupChildViewController:homeVC title:@"特产" imageName:@"icon_fruit_normal" selectedImageName:@"icon_fruit_selected"];
    
    HHDataPageViewController *dataVC = [[HHDataPageViewController alloc] init];
    [self setupChildViewController:dataVC title:@"旅游" imageName:@"icon_build_normal" selectedImageName:@"icon_build_selected"];
    
    HHVideoViewController *videoVC = [[HHVideoViewController alloc] init];
    [self setupChildViewController:videoVC title:@"美景" imageName:@"icon_video_normal" selectedImageName:@"icon_video_selected"];
    
    HHMineViewController *mineVC = [[HHMineViewController alloc] init];
    [self setupChildViewController:mineVC title:@"我" imageName:@"icon_mine_normal" selectedImageName:@"icon_mine_selected"];
    
    self.viewControllers = _VCS;
}

- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    viewController.title = title;
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666"], NSFontAttributeName:[UIFont systemFontOfSize:10.0]} forState:UIControlStateNormal];
    //选中字体颜色
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#372f84"], NSFontAttributeName:[UIFont systemFontOfSize:10.0]} forState:UIControlStateSelected];
    
    //包装导航栏控制器
    HHRootNavigationController *nav = [[HHRootNavigationController alloc] initWithRootViewController:viewController];
    
    [_VCS addObject:nav];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

- (void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow
{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    } else {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
}

#pragma mark -- 中间按钮的代理点击事件 --
- (void)tabBarDidClickPlusButton:(HHTabBar *)tabBar
{
    HHPlusViewController *plusVC = [[HHPlusViewController alloc] init];
    [self presentViewController:plusVC animated:YES completion:nil];
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
