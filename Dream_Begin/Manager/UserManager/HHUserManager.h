//
//  HHUserManager.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHUserInfo.h"
#import "HHIMManager.h"

typedef NS_ENUM(NSInteger, UserLoginType) {
    //未知
    KUserLoginTypeUnkown = 0,
    //微信登录
    KUserLoginTypeWeChat,
    //QQ登录
    KUserLoginTypeQQ,
    //账号登录
    KUserLoginTypePwd
};

typedef void (^loginBlock)(BOOL success, NSString *desc);

/**
    包含用户相关服务
 */

@interface HHUserManager : NSObject

//单例
SINGLETON_FOR_HEADER(HHUserManager)

//当前用户
@property (nonatomic, strong) HHUserInfo *curUserInfo;
@property (nonatomic, assign) UserLoginType loginType;
@property (nonatomic, assign) BOOL isLogined;

#pragma mark -- 登录相关 --
/**
    三方登录
 
    @param loginType 登录方式
    @param completion 回调
 */
- (void)login:(UserLoginType)loginType completion:(loginBlock)completion;

/**
    带参登录
 
    @param loginType 登录方式
    @param params 参数，手机和账号登录
    @param completion 回调
 */
- (void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion;

//自动登录
- (void)autoLoginToServer:(loginBlock)completion;

//退出登录
- (void)logout:(loginBlock)completion;

/**
    加载缓存的用户数据
 
    return 是否成功
 */
- (BOOL)loadUserInfo;

@end
