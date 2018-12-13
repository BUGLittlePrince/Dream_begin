//
//  HHGuidePageViewController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

/*****
 *****
    暂时不用这个控制器
 *****
 *****/

#import "HHGuidePageViewController.h"
//#import "HHGuidePageHUD.h"
//#import "HHLoginViewController.h"

//@interface HHGuidePageViewController ()<presentToLoginViewDelegate>
//
//@end

@implementation HHGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 静态引导页
//    [self setStaticGuidePage];
    self.isHidenNaviBar = YES;
    
    // 动态引导页
    // [self setDynamicGuidePage];
    
    // 视频引导页
    // [self setVideoGuidePage];
}

#pragma mark --设置APP静态图片引导页--
//- (void)setStaticGuidePage
//{
//    NSArray *imageNameArray = @[@"guideImage1.jpg",@"guideImage2.jpg",@"guideImage3.jpg",@"guideImage4.jpg",@"guideImage5.jpg"];
//    HHGuidePageHUD *guidePage = [[HHGuidePageHUD alloc] hh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
//    guidePage.myDelegate = self;
//    guidePage.slideInto = YES;
//    [self.view addSubview:guidePage];
//}
//
//#pragma mark --设置APP动态图片引导页--
//- (void)setDynamicGuidePage
//{
//    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
//    HHGuidePageHUD *guidePage = [[HHGuidePageHUD alloc] hh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
//    guidePage.myDelegate = self;
//    guidePage.slideInto = YES;
//    [self.view addSubview:guidePage];
//}
//
//#pragma mark --设置APP视频引导页--
//- (void)setVideoGuidePage
//{
//    NSURL *videoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
//    HHGuidePageHUD *guidePage = [[HHGuidePageHUD alloc] hh_initWithFrame:self.view.frame videoURL:videoUrl];
//    guidePage.myDelegate = self;
//    [self.view addSubview:guidePage];
//}

- (void)presentToLoginVC
{
//    HHLoginViewController *loginVC = [HHLoginViewController new];
//    [self presentViewController:loginVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
