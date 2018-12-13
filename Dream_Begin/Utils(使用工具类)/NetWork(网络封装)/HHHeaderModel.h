//
//  HHHeaderModel.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/19.
//  Copyright © 2018年 hanhong. All rights reserved.
//

/**
 header 参数model
 */

#import <Foundation/Foundation.h>
#import "OpenUDID.h"

@interface HHHeaderModel : NSObject

//用户ID
@property (nonatomic, assign) long long userId;
//设备号
@property (nonatomic, copy) NSString *imei;
//0 位置、1 安卓、2 iOS
@property (nonatomic, assign) NSInteger os_type;
//当前app版本号
@property (nonatomic, copy) NSString *version;
//来源渠道，苹果使用：@"App Store"
@property (nonatomic, copy) NSString *channel;
//客户端唯一标示，后台用来判断是否更换设备
@property (nonatomic, copy) NSString *clientId;
//内部维修的应用版本，随版本递增
@property (nonatomic, assign) NSInteger versioncode;
//手机型号
@property (nonatomic, copy) NSString *mobile_model;
//手机品牌
@property (nonatomic, copy) NSString *mobile_brand;
//用户登录后分配的登录Token
@property (nonatomic, copy) NSString *token;

@end
