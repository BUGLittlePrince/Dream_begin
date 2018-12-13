//
//  HHTextField.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/28.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTextField : UIView

//注释信息
@property (nonatomic, copy) NSString *hh_placeholder;
//光标颜色
@property (nonatomic, strong) UIColor *cursorColor;
//注释普通状态下颜色
@property (nonatomic, strong) UIColor *placeholderNormalStateColor;
//注释选中状态下颜色
@property (nonatomic, strong) UIColor *placeholderSelectStateColor;
//是否是密码
@property (nonatomic, assign) BOOL isSecureTextEntry;

@end
