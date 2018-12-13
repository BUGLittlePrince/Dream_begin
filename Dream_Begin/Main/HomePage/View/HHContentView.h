//
//  HHcontentView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/9.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTitleStyleLogic.h"

@class HHContentView;

@protocol HHContentViewDelegate <NSObject>

@optional
- (void)contentViewWith:(HHContentView *)contentView progress:(CGFloat)progress sourceIndex:(CGFloat)sourceIndex targetIndex:(CGFloat)targetIndex;
//内容视图结束滚动
- (void)contentViewEndScrollWithContentView:(HHContentView *)contentView;

@end

@interface HHContentView : UIView

/**
 *  创建contentView
 *
 *  @param frame contentView的frame
 *  @param childVCs 所有子控制器数组
 *  @param parentViewController 父控制器
 *  @param style 标题样式
 *
 *  return contentView
 */
- (HHContentView *)initWithFrame:(CGRect)frame childVCs:(NSArray <UIViewController *> *)childVCs parentViewController:(UIViewController *)parentViewController style:(HHTitleStyleLogic *)style;

/**
 *  点击标题之后通过代理 滚动式图
 *
 *  @param currentIndex 滚动到第几个
 */
- (void)setCurrentIndex:(NSInteger)currentIndex;

@property (nonatomic, weak) id<HHContentViewDelegate> myDelegate;

@end
