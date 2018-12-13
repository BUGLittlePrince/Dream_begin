//
//  HHPageView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/9.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTitleStyleLogic.h"
#import "HHTitleView.h"
#import "HHContentView.h"

@interface HHPageView : UIView

/**
 *  直接在需要pageView的控制器中，一句代码实例化（调用此方法），如需要更改titleView和contentView的frame在HHTitleStyleLogic.m中重新设置frame即可
 *  @param frame pageView的frame
 *  @param titles 标题数组
 *  @param style 设置pageView的多个属性
 *  @param childVCs 子控制器数组
 *  @param parentVC 父控制器
 *
 *  return pageView
 */
- (HHPageView *)initWithFrame:(CGRect)frame titles:(NSArray <NSString *> *)titles style:(HHTitleStyleLogic *)style childVCs:(NSArray <UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC;

@end
