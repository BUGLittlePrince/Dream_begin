//
//  HHTitleStyleLogic.h
//  Dream_Begin
//
//  Created by hanhong on 2018/5/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTitleStyleLogic : NSObject

//=================内容的属性=================//
/**
    内容是否需要滑动，如果设为NO，则只有点击标题才会出现切花视图
 */
@property (nonatomic, assign) BOOL isContentViewScrollEnable;


//=================标题的属性==================//
//是否是滚动的title
@property (nonatomic, assign) BOOL isTitleViewScrollEnable;
//普通title的颜色
@property (nonatomic, strong) UIColor *normalColor;
//选中title的颜色
@property (nonatomic, strong) UIColor *selectedColor;
//title字体大小
@property (nonatomic, strong) UIFont *font;
//滚动title的字体间距
@property (nonatomic, assign) CGFloat titleMargin;

//=================标题带底部细线===============//
//是否显示底部滚动条
@property (nonatomic, assign) BOOL isShowBottomLine;
//底部滚动条的颜色
@property (nonatomic, assign) UIColor *bottomLineColor;
//底部滚动条高度
@property (nonatomic, assign) CGFloat bottomLineH;


//=================标题带缩放==================//
//是否进行缩放
@property (nonatomic, assign) BOOL isNeedScale;
//缩放比例
@property (nonatomic, assign) CGFloat scaleRange;


//=================标题带背景==================//
//是否显示遮盖
@property (nonatomic, assign) BOOL isShowCover;
//遮盖背景色
@property (nonatomic, strong) UIColor *coverBgColor;
//文字和遮盖间隙
@property (nonatomic, assign) CGFloat coverMargin;
//遮盖高度
@property (nonatomic, assign) CGFloat coverH;
//设置圆角大小
@property (nonatomic, assign) CGFloat coverRadius;

@end
