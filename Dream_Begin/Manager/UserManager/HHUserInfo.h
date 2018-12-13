//
//  HHUserInfo.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UserGender) {
    UserGenderUnKnow = 0,
    //男
    UserGenderMale,
    //女
    UserGenderFemale
};

@interface HHUserInfo : NSObject

//用户ID
@property (nonatomic, assign) long long userId;
//展示用的用户ID
@property (nonatomic, copy) NSString *idcard;
//头像
@property (nonatomic, copy) NSString *photo;
//昵称
@property (nonatomic, copy) NSString *nickName;
//性别
@property (nonatomic, assign) UserGender sex;
//IM账号
@property (nonatomic, copy) NSString *imId;
//IM密码
@property (nonatomic, copy) NSString *imPass;
//用户等级
@property (nonatomic, assign) NSInteger degreeId;
//用户登录后分配的登录的Token
@property (nonatomic, copy) NSString *token;

@end
