//
//  HHCycleScrollView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HHCycleScrollViewPageControlAlimentRight,
    HHCycleScrollViewPageControlAlimentCenter
}HHCycleScrollViewPageControlAliment;

typedef enum {
    //系统自带经典样式
    HHCycleScrollViewPageControlStyleClassic,
    //动画效果pageCtrol
    HHCycleScrollViewPageControlStyleAnimated,
    //不显示pageControl
    HHCycleScrollViewPageControlStyleNone
}HHCycleScrollViewPageControlStyle;

@class HHCycleScrollView;

@protocol HHCycleScrollViewDelegate <NSObject>

@optional
/** 点击图片回调 */
- (void)cycleScrollView:(HHCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)cycleScrollView:(HHCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;

#pragma mark -- 自定义轮播cell --
//在此方法中返回自定义cell的class
- (Class)customCollectionViewCellClassForCycleScrollView:(HHCycleScrollView *)view;
//在此方法中为cell填充数据以及其它的一系列设置
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(HHCycleScrollView *)view;

@end

@interface HHCycleScrollView : UIView

/** 初始轮播图（推荐使用）*/
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<HHCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;

/** 本地图片轮播初始化方法 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup;
/** infiniteLoop:是否无限循环 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageNamesGroup:(NSArray *)imageNamesGroup;

#pragma mark -- 数据源API --
/** 网络图片 url string 数组*/
@property (nonatomic, strong) NSArray *imageURLStringsGroup;
/** 每张图片对应要显示的文字数组*/
@property (nonatomic, strong) NSArray *titlesGroup;
/** 本地图片数组*/
@property (nonatomic, strong) NSArray *localizationImageNamesGroup;

#pragma mark -- 滚动控制API --
/** 自动滚动间隔时间，默认2s*/
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否无限循环，默认为YES*/
@property (nonatomic, assign) BOOL infiniteLoop;
/** 是否自动滚动，默认为YES*/
@property (nonatomic, assign) BOOL autoScroll;
/** 图片滚动方向，默认是水平方向*/
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, weak) id<HHCycleScrollViewDelegate>delegate;

/** block方式监听点击*/
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);
/** block方式监听滚动*/
@property (nonatomic, copy) void (^itemDidScrollOperationBlock)(NSInteger currentIndex);

/** 解决viewWillAppear出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppear;

#pragma mark -- 自定义样式API --
/** 轮播图的contenMode，默认为UIViewContentModeScaleToFill*/
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode;
/** 占位图，用于网络未加载到图片时*/
@property (nonatomic, strong) UIImage *placeholderImage;
/** 是否显示分页控件*/
@property (nonatomic, assign) BOOL showPageControl;
/** 是否在只有一张图片时隐藏pageControl，默认为YES*/
@property (nonatomic, assign) BOOL hidesForSinglePage;
/** 只展示文字轮播*/
@property (nonatomic, assign) BOOL onlyDisplayText;
/** pageControl样式，默认为动画样式*/
@property (nonatomic, assign) HHCycleScrollViewPageControlStyle pageControlStyle;
/** 分页控件位置*/
@property (nonatomic, assign) HHCycleScrollViewPageControlAliment pageControlAliment;
/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量*/
@property (nonatomic, assign) CGFloat pageControlBottomOffset;
/** 分页控件距离轮播图的右边间距（在默认间距基础上）的偏移量*/
@property (nonatomic, assign) CGFloat pageControlRightOffset;
/** 分页控件小圆标大小*/
@property (nonatomic, assign) CGSize pageControlDotSize;
/** 当前分页控件小圆标颜色*/
@property (nonatomic, strong) UIColor *currentPageDotColor;
/** 其它分页控件小圆标颜色*/
@property (nonatomic, strong) UIColor *pageDotColor;
/** 当前分页控件小圆标图片*/
@property (nonatomic, strong) UIImage *currentPageDotImage;
/** 其它分页控件小圆标图片*/
@property (nonatomic, strong) UIImage *pageDotImage;
/** 轮播文字label字体颜色*/
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/** 轮播文字label字体大小*/
@property (nonatomic, strong) UIFont *titleLabelTextFont;
/** 轮播文字label背景颜色*/
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
/** 轮播文字label高度*/
@property (nonatomic, assign) CGFloat titleLabelHeight;
/** 轮播文字label对齐方式*/
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;
/** 滚动手势禁用（文字轮播较实用）*/
- (void)disableScrollGesture;

#pragma mark -- 清除缓存API --
/** 清除图片缓存，统一使用SDWebImage管理图片加载和缓存*/
+ (void)clearImagesCache;
/** 清除图片缓存（兼容旧版本方法）*/

@end
