//
//  AppDelegate+HHAppService.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/9.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "AppDelegate.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

/**
    包含第三方和应用内业务的实现，减轻入口代码的压力
 */
@interface AppDelegate (HHAppService)

//初始化服务
- (void)initService;

//初始化window
- (void)initWindow;

//初始化友盟（UMeng）
- (void)initUMeng;

//初始化用户系统
- (void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;

//初始化网络配置
- (void)netWorkConfig;

//单例
+ (AppDelegate *)shareAppDelegate;

/**
    当前顶层控制器
 */
- (UIViewController *)getCurrentVC;
- (UIViewController *)getCurrentUIVC;

@end
