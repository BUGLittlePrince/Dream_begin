//
//  HHTitleView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTitleStyleLogic.h"

@class HHTitleView;

@protocol HHTitleViewDelegate <NSObject>

- (void)titleViewWithTitleView:(HHTitleView *)titleView selectedIndex:(NSInteger)selectedIndex;

@end

@interface HHTitleView : UIView

- (HHTitleView *)initWithFrame:(CGRect)frame titles:(NSArray <NSString *> *)titles style:(HHTitleStyleLogic *)style;
- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;
- (void)contentViewDidEndScroll;

@property (nonatomic, weak) id<HHTitleViewDelegate> myDelegate;

@end
