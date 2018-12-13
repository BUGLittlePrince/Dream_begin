//
//  HHAppManager.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHAppManager.h"
#import "HHADPageView.h"
#import "HHGuidePageHUD.h"
#import "HHLoginViewController.h"
#import "HHRootWebViewController.h"

@interface HHAppManager ()

@end

@implementation HHAppManager

+ (void)appStart
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [kUserDefaults setBool:YES forKey:@"firstLaunch"];
        //app第一次启动，有引导页
        //1.静态引导页
        NSArray *imageNameArray = @[@"guideImage1.jpg",@"guideImage2.jpg",@"guideImage3.jpg",@"guideImage4.jpg",@"guideImage5.jpg"];
        HHGuidePageHUD *guidePage = [[HHGuidePageHUD alloc] hh_initWithFrame:kScreen_Bounds imageNameArray:imageNameArray buttonIsHidden:NO];
        guidePage.slideInto = YES;
        guidePage = guidePage;
        
        //2.动态引导页
//        NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
//        HHGuidePageHUD *guidePage = [[HHGuidePageHUD alloc] hh_initWithFrame:kScreen_Bounds imageNameArray:imageNameArray buttonIsHidden:YES];
//        guidePage.slideInto = YES;
        
        //3.视频引导页
//        NSURL *videoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
//        HHGuidePageHUD *guidePage = [[HHGuidePageHUD alloc] hh_initWithFrame:kScreen_Bounds videoURL:videoUrl];
    } else {
        //app第二次启动，没有引导页
        //加载广告
        HHADPageView *adView = [[HHADPageView alloc] initWithFrame:kScreen_Bounds wTapBlock:^{
            HHRootNavigationController *loginNavi = [[HHRootNavigationController alloc] initWithRootViewController:[[HHRootWebViewController alloc] initWithUrl:@"https://segmentfault.com/q/1010000004065146?_ea=476574"]];
            [kRootViewController presentViewController:loginNavi animated:YES completion:nil];
        }];
        adView = adView;
    }
}
#warning 后续

+ (void)showFPS
{
    
}

@end
