//
//  HHPieView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPieModel.h"

@class HHPieView;

@protocol PieViewDelegate<NSObject>

- (void)pie:(HHPieView *)pieView didSelectedAtIndex:(NSInteger)index;

@end

@interface HHPieView : UIView

@property (nonatomic, weak) id<PieViewDelegate>delegate;
//是否可点击，默认YES
@property (nonatomic, assign) BOOL isSelect;
//是否有点击效果，默认YES
@property (nonatomic, assign) BOOL isSelectAnimation;

//初始化
- (instancetype)initWithFrame:(CGRect)frame models:(NSArray <HHPieModel *> *)array;

//刷新
- (void)reloadWithArray:(NSArray <HHPieModel *> *)array;

//选中当前的index
- (void)selectAtIndex:(NSInteger)index;

//选择当前的model
- (void)selectAtModel:(HHPieModel *)model;

//重置动画
- (void)initAnimation;

//移除选中状态
- (void)removeSelectStatus;

@end
