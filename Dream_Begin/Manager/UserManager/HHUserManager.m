//
//  HHUserManager.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHUserManager.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation HHUserManager

SINGLETON_FOR_CLASS(HHUserManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKick) name:KNotificationOnKick object:nil];
    }
    return self;
}

#pragma mark -- 三方登录 --
- (void)login:(UserLoginType)loginType completion:(loginBlock)completion
{
    [self login:loginType params:nil completion:completion];
    
}

#pragma mark -- 带参数登录 --
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion
{
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == KUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    } else if (loginType == KUserLoginTypeWeChat) {
        platFormType = UMSocialPlatformType_WechatSession;
    } else {
        platFormType = UMSocialPlatformType_UnKnown;
    }
    
    //第三方登录
    if (loginType != KUserLoginTypePwd) {
        [MBProgressHUD showActivityMessageInView:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO, error.localizedDescription);
                }
            } else {
                UMSocialUserInfoResponse *response = result;
                
                //登录参数
                NSDictionary *params = @{@"openid":response.openid, @"nickname":response.name, @"iconurl":response.iconurl, @"sex":[response.unionGender isEqualToString:@"男"] ? @1 : @2, @"cityname":response.originalResponse[@"city"], @"fr":@(loginType)};
                self.loginType = loginType;
                
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    } else {
        //账号登录
    }
}

#pragma mark -- 手动登录到服务器 --
- (void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion
{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    [HHNetworkHelper POST:NSStringFormat(@"%@%@", URL_main, URL_user_login) parameters:params success:^(id responseObject) {
        [self LoginSuccess:responseObject completion:completion];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if (completion) {
            completion(NO, error.localizedDescription);
        }
    }];
}

#pragma mark -- 自动登录到服务器 --
- (void)autoLoginToServer:(loginBlock)completion
{
    [HHNetworkHelper POST:NSStringFormat(@"%@%@", URL_main, URL_user_auto_login) parameters:nil success:^(id responseObject) {
        [self LoginSuccess:responseObject completion:completion];
    } failure:^(NSError *error) {
        if (completion) {
            completion(NO, error.localizedDescription);
        }
    }];
}

#pragma mark -- 登录成功处理 --
- (void)LoginSuccess:(id)responseObject completion:(loginBlock)completion
{
    if (ValidDict(responseObject[@"data"])) {
        NSDictionary *data = responseObject[@"data"];
        if (ValidStr(data[@"imId"]) && ValidStr(data[@"imPass"])) {
            //登录IM
            [[HHIMManager sharedHHIMManager] IMLogin:data[@"imId"] IMPwd:data[@"imPass"] completion:^(BOOL success, NSString *desc) {
                [MBProgressHUD hideHUD];
                if (success) {
                    self.curUserInfo = [HHUserInfo modelWithDictionary:data];
                    [self saveUserInfo];
                    self.isLogined = YES;
                    if (completion) {
                        completion(YES, nil);
                    }
                    KPostNotification(KNotificationLoginStateChange, @YES);
                } else {
                    if (completion) {
                        completion(NO, @"IM登录失败");
                    }
                    KPostNotification(KNotificationLoginStateChange, @NO);
                }
            }];
        } else {
            if (completion) {
                completion(NO, @"登录返回数据异常");
            }
            KPostNotification(KNotificationLoginStateChange, @NO);
        }
    } else {
        if (completion) {
            completion(NO, @"登录放回数据异常");
        }
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}

#pragma mark -- 存储用户信息 --
- (void)saveUserInfo
{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
        NSDictionary *dict = [self.curUserInfo modelToJSONObject];
        [cache setObject:dict forKey:KUserModelCache];
    }
}

#pragma mark -- 加载缓存的用户信息 --
- (BOOL)loadUserInfo
{
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    NSDictionary *userDict = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDict) {
        self.curUserInfo = [HHUserInfo modelWithJSON:userDict];
        return YES;
    }
    return NO;
}

#pragma mark -- 被踢下线 --
- (void)onKick
{
    [self logout:nil];
}

#pragma mark -- 退出登录 --
- (void)logout:(void (^)(BOOL, NSString *))completion
{
    //设置角标为0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //关闭通知中心
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    //打开通知中心
    //[[UIApplicationsharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert)];
    //被踢下线通知用户退出直播间
    //[[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];
    
    [[HHIMManager sharedHHIMManager] IMLogout];
    
    self.curUserInfo = nil;
    self.isLogined = NO;
    
    //移除缓存
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES, nil);
        }
    }];
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}

@end
