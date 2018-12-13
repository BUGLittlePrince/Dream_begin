//
//  HHFourPingTransition.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/28.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HHPresentOneTransitionType) {
    HHPresentOneTransitionTypePresent = 0,//管理present动画
    HHPresentOneTransitionTypeDismiss//管理dismiss动画
};

@interface HHFourPingTransition : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic,assign) HHPresentOneTransitionType type;

+ (instancetype)transitionWithTransitionType:(HHPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(HHPresentOneTransitionType)type;

@end
