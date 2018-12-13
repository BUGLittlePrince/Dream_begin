//
//  HHGuidePageHUD.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BOOLFORKEY @"hh_GuidePage"

@protocol presentToLoginViewDelegate <NSObject>

@optional
- (void)presentToLoginVC;

@end

@interface HHGuidePageHUD : UIView

//是否支持滑动进入APP(默认为NO--不支持滑动进入APP | 只有在buttonIsHidden为YES--隐藏状态下可以用；buttonIsHidden为NO--显示状态下直接点击按钮进入)
//新增视频引导页同样不支持滑动进入APP
@property (nonatomic, assign) BOOL slideInto;

/**
 *  HHGuidePageHUD(图片引导页 | 可自动识别动态图片和静态图片)
 *
 *  @param frame 位置大小
 *  @param imageNameArray 引导页图片数组
 *  @param isHidden   开始体验按钮是否隐藏(YES:隐藏--引导页完成自动进入APP首页; NO:不隐藏--引导页完成点击开始体验按钮进入APP主页)
 *
 *  @return HHGuidePageHUD对象
 **/
- (instancetype)hh_initWithFrame:(CGRect)frame imageNameArray:(NSArray <NSString *> *)imageNameArray buttonIsHidden:(BOOL)isHidden;

/**
 *  HHGuidePageHUD(视频引导页)
 *
 *  @param frame 位置大小
 *  @param videoURL 引导页视频地址
 *
 *  @return HHGuidePageHUD对象
 **/
- (instancetype)hh_initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURL;

@property (nonatomic, weak) id <presentToLoginViewDelegate> myDelegate;

@end
