//
//  HHScrollPositionView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/7.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHScrollPositionTitleContentView;

@interface HHScrollPositionView : UIView

//标题数组
@property (nonatomic, strong) NSArray *titlesArr;
//子控件宽度
@property (nonatomic, assign) CGFloat titleViewWidth;
//顶部title容器
@property (nonatomic) HHScrollPositionTitleContentView *titleContentView;
//传入自己需要联动的内容容器scrollView
@property (nonatomic) UIScrollView *contentScrollView;

/**
    通过索引确定选中的标题
 */
- (void)resetTitleViewState:(NSInteger)index;

@end

@interface HHScrollPositionTitleContentView : UIView

//目标点
@property (nonatomic) CGPoint indexPoint;
//x坐标
@property (nonatomic, assign) CGFloat scrollX;
//是否滚动
@property (nonatomic, assign) BOOL scroll;
//是否向右移动
@property (nonatomic, assign) BOOL moveRight;
//是否向左移动
@property (nonatomic, assign) BOOL moveLeft;
//固定宽度
@property (nonatomic, assign) CGFloat fixedWidth;

@end
