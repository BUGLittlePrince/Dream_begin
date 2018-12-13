//
//  AppDelegate+HHAppService.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/9.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "AppDelegate+HHAppService.h"
#import "YTKNetwork.h"
#import <UMSocialCore/UMSocialCore.h>
#import "OpenUDID.h"
#import "HHLoginViewController.h"

@implementation AppDelegate (HHAppService)

#pragma mark -- 初始化服务 --
- (void)initService
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNotificationLoginStateChange object:nil];
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:KNotificationNetWorkStateChange object:nil];
}

#pragma mark -- 初始化window --
- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    
    //避免同一个界面有多个按钮，出现一块点击的情况
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    
    //适配iOS11，iPhoneX, 避免滚动视图顶部出现20的空白以及push或者pop的时候页面有一个上移或者下移的异常动画的问题(但是会引起系统相册界面整体上移，调用系统相册时在对应的代码中具体解决)
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark -- 初始化网络配置 --
- (void)netWorkConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = URL_main;
}

#pragma mark -- 初始化用户系统 --
- (void)initUserManager
{
    HHLog(@"设备IMEI：%@", [OpenUDID value]);
    if ([userManager loadUserInfo]) {
        //如果有本地数据，先展示tabBar，随后异步自动同步
        self.mainTabBar = [HHMainTabBarController new];
        self.window.rootViewController = self.mainTabBar;
        
        //自动登录
        [userManager autoLoginToServer:^(BOOL success, NSString *desc) {
            if (success) {
                HHLog(@"自动登录成功");
                KPostNotification(KNotificationAutoLoginSuccess, nil);
            } else {
                [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@", desc)];
            }
        }];
    } else {
        //没有登录过，展示登录界面
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}

#pragma mark --登录状态处理--
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) {
        //登录成功加载主窗口控制器
        //为避免自动登录成功刷新tabbar
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[HHMainTabBarController class]]) {
            self.mainTabBar = [HHMainTabBarController new];
            
            CATransition *animate = [CATransition animation];
            //设置动画的类型(立体)
            animate.type = @"cube";
            //设置动画的方向
            animate.subtype = kCATransitionFromRight;
            animate.duration = 0.3f;
            
            self.window.rootViewController = self.mainTabBar;
            [kAppWindow.layer addAnimation:animate forKey:@"revealAnimation"];
        }
    } else {
        //登录失败加载登录页面控制器
        self.mainTabBar = nil;
        HHRootNavigationController *loginNavi = [[HHRootNavigationController alloc] initWithRootViewController:[HHLoginViewController new]];
        
        CATransition *animate = [CATransition animation];
        //设置动画的类型(淡出)
        animate.type = @"fade";
        //设置动画的方向
        animate.subtype = kCATransitionFromRight;
        animate.duration = 0.3f;
        
        self.window.rootViewController = loginNavi;
        [kAppWindow.layer addAnimation:animate forKey:@"revealAnimation"];
    }
    
    //展示FPS
}

#pragma mark -- 网络状态变化 --
- (void)netWorkStateChange:(NSNotification *)notification
{
    BOOL isNetWork = [notification.object boolValue];
    
    if (isNetWork) {
        //有网
        if ([userManager loadUserInfo] && !isLogin) {
            //有用户数据，并且未登录成功，重新来一次自动登录
            [userManager autoLoginToServer:^(BOOL success, NSString *desc) {
                if (success) {
                    HHLog(@"网络变化后，自动登录成功");
                    KPostNotification(KNotificationAutoLoginSuccess, nil);
                } else {
                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@", desc)];
                }
            }];
        }
    } else {
        //登录失败加载登录页面控制器
        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
    }
}

#pragma mark -- 友盟初始化 --
- (void)initUMeng
{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appKey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
    
    [self configUSharePlatforms];
}

#pragma mark -- 配置第三方 --
- (void)configUSharePlatforms
{
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
    
    //移除响应平台的分享，eg：微信收藏
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    //设置分享到QQ互联的appID
    //U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的参数传进即可
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent appSecret:nil redirectURL:nil];
}

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统。注：此方法是老方法，建议同时实现 application:openURL:options: 若APP不支持iOS9以下，可直接废弃当前，直接使用application:openURL:options:
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        //其他SDK的回调，如支付等
    }
    return result;
}

#pragma mark -- 9.0以后使用新API接口 --
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        //其他SDK的回调，如支付等
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转到支付宝钱包进行支付，处理支付结果
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//            }];
            return YES;
        }
    }
    return result;
}

#pragma mark -- 网络监听状态 --
- (void)monitorNetworkStatus
{
    //网络状态改变一次，networkStatusWithBlock就会响应一次
    [HHNetworkHelper netWorkStatusWithBlock:^(HHNetworkStatusType status) {
        switch (status) {
                //位置网络
            case HHNetworkStatusUnknow:
                HHLog(@"网络环境：未知网络");
                break;
                
                //无网络
            case HHNetworkStatusNotReachable:
                HHLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
                
                //手机网络
            case HHNetworkStatusReachableViaWWAN:
                HHLog(@"网络环境：手机自带网络");
                break;
                
                //无线网络
            case HHNetworkStatusReachableViaWiFi:
                HHLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                break;
                
            default:
                break;
        }
    }];
}

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWindow in windows) {
            if (tmpWindow.windowLevel == UIWindowLevelNormal) {
                window = tmpWindow;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

- (UIViewController *)getCurrentUIVC
{
    UIViewController *superVC = [self getCurrentVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController *tabSelectVC = ((UITabBarController *)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    } else {
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *) superVC).viewControllers.lastObject;
        }
    }
    return superVC;
}

@end
