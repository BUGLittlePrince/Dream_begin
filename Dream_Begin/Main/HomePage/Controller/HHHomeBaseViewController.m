//
//  HHHomeBaseViewController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHHomeBaseViewController.h"
#import "HHScrollPositionView.h"
#import "HHHomePageViewController.h"
#import "HHPageView.h"
#import "Dream_Begin-Swift.h"

@interface HHHomeBaseViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HHScrollPositionView *positionView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HHHomeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollViewSubViews];
}

- (void)addScrollViewSubViews
{
    HHHomePageViewController *pageVC = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:pageVC.view];
    
//    HHHomeWaterViewController *waterVC = [[HHHomeWaterViewController alloc] init];
//    [self.scrollView addSubview:waterVC.view];

    HHHomePageViewController *waterVC = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:waterVC.view];

    HHHomePageViewController *pageVC2 = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:pageVC2.view];
    
    HHHomePageViewController *pageVC3 = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:pageVC3.view];
    
    HHHomePageViewController *pageVC4 = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:pageVC4.view];
    
    HHHomePageViewController *pageVC5 = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:pageVC5.view];
    
    HHHomePageViewController *pageVC6 = [[HHHomePageViewController alloc] init];
    [self.scrollView addSubview:pageVC6.view];
    
    NSMutableArray *titlesArray = [NSMutableArray arrayWithObjects:@"推荐", @"干果", @"水果", @"补品", @"珍惜物种", @"话题", @"订阅", nil];
    NSMutableArray *childVCArray = [NSMutableArray arrayWithObjects:pageVC, waterVC, pageVC2, pageVC3, pageVC4, pageVC5, pageVC6, nil];
    HHPageView *pageView = [[HHPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - kTabBarHeight) titles:titlesArray style:nil childVCs:childVCArray parentVC:self];
    for (int i = 0; i < childVCArray.count; i ++) {
        
    }
    pageView.backgroundColor = KWhiteColor;
    
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
