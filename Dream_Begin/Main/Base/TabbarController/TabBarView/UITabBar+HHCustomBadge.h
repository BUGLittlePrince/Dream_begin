//
//  UITabBar+HHCustomBadge.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/24.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

//角标类型：图标、数字、没有
typedef NS_ENUM(NSUInteger, CustomBadgeType) {
    kCustomBadgeStyleRedDot,
    kCustomBadgeStyleNumber,
    kCustomBadgeStyleNone
};

@interface UITabBar (HHCustomBadge)

//设置tab上icon的宽度，用于调整badge的位置
- (void)setTabIconWidth:(CGFloat)width;

//设置badge的top
- (void)setBadgeTop:(CGFloat)top;

//设置badge样、数字
- (void)setBadgeStyle:(CustomBadgeType)type value:(NSInteger)badgeValue atIndex:(NSInteger)index;

@end
