//
//  UIDevice+HHPopViewExtension.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/11/27.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIDeviceFamily) {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
};

@interface UIDevice (HHPopViewExtension)

/**
 *
 * 返回 `machine-readable` 的设备型号，比如："iPhone4,1"
 *
 */
- (NSString *)modelName;

/**
 *
 * 设备类型
 *
 */
- (UIDeviceFamily)deviceFamily;

/**
 *
 * 导航条高度
 *
 */
- (CGFloat)navigationBarHeight;

/**
 *
 * 工具条高度
 *
 */
- (CGFloat)tabBarHeight;

/**
 *
 * 是否模拟器
 *
 */
- (BOOL)isSimulator;

/**
 *
 * 是否iPhone X
 *
 */
- (BOOL)isIphoneX;

/**
 *
 * 顶部安全区高度
 *
 */
- (CGFloat)safeAreaTop;

/**
 *
 * 底部安全区高度
 *
 */
- (CGFloat)safeAreaBottom;

@end

NS_ASSUME_NONNULL_END
