//
//  HHCustomPageControl.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/5/13.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 页码对齐方式，默认SYPageControlAlignmentDefault
typedef NS_ENUM(NSInteger, HHPageControlAlignment)
{
    HHPageControlAlignmentDefault = 0,

    HHPageControlAlignmentLeft = 1,

    HHPageControlAlignmentRight = 2,

    HHPageControlAlignmentCenter = HHPageControlAlignmentDefault,

    HHPageControlAlignmentEqual = 4,

    /// SYPageControlTypeLine时有效
    HHPageControlAlignmentBottom = 5,
};

/// 页码样式，默认SYPageControlTypeSquare
typedef NS_ENUM(NSInteger, HHPageControlType)
{
    HHPageControlTypeSquare = 0,

    HHPageControlTypeCircle = 1,

    HHPageControlTypeLine = 2,

    HHPageControlTypeImage = 3,
};

@interface HHCustomPageControl : UIView

- (instancetype)initWithFrame:(CGRect)frame;

/// 页码数量，默认0
@property (nonatomic, assign) NSInteger numberOfPages;
/// 当前页码，默认0，取值范围是0~numberOfPages-1
@property (nonatomic, assign) NSInteger currentPage;

/// 只有一页时是否隐藏页码，默认NO
@property (nonatomic, assign) BOOL hidesForSinglePage;

/// 页码非高亮颜色，默认灰色
@property(nonatomic, strong) UIColor *pageIndicatorColor;
/// 页码高亮时颜色，默认黑色
@property(nonatomic, strong) UIColor *currentPageIndicatorColor;

/// 页码非高亮图标，默认无
@property(nonatomic, strong) UIImage *pageIndicatorImage;
/// 页码高亮时图标，默认无
@property(nonatomic, strong) UIImage *currentPageIndicatorImage;

/// 页码样式，默认SYPageControlTypeSquare
@property(nonatomic, assign) HHPageControlType pageControlType;
/// 页码对齐方式，默认SYPageControlAlignmentDefault
@property(nonatomic, assign) HHPageControlAlignment pageControlAlignment;

/// 页码高亮时放大倍数，默认1.0，取值范围1.0~2.0
@property(nonatomic, assign) CGFloat transformScale;

/// 页码序号是否显示，默认NO
@property(nonatomic, assign) BOOL showPageNumber;
/// 页码序号非高亮时颜色，默认灰色
@property(nonatomic, strong) UIColor *pageNumberColor;
/// 页码序号高亮时颜色，默认黑色
@property(nonatomic, strong) UIColor *currentPageNumberColor;
/// 页码序号非高亮时字体大小，默认6.0
@property(nonatomic, strong) UIFont *pageNumberFont;
/// 页码序号高亮时字体大小，默认6.0
@property(nonatomic, strong) UIFont *currentPageNumberFont;

/// 页码间距，默认6.0
@property(nonatomic, assign) CGFloat pageMargin;
/// 页码大小-高，默认6.0
@property(nonatomic, assign) CGFloat pageSizeHeight;
/// 页码大小-宽，默认6.0
@property(nonatomic, assign) CGFloat pageSizeWidth;
/// 适配图标大小，默认NO
@property (nonatomic, assign) BOOL shouldAutoresizingImage;


#pragma mark - 链式属性

/// 页码数量
- (HHCustomPageControl *(^)(NSInteger pages))pages;

/// 页码当前页
- (HHCustomPageControl *(^)(NSInteger page))page;

/// 页码单个时是否隐藏
- (HHCustomPageControl *(^)(BOOL hidden))hidesPageWhileSingle;

/// 页码非高亮颜色
- (HHCustomPageControl *(^)(UIColor *color))pageColor;

/// 页码高亮颜色
- (HHCustomPageControl *(^)(UIColor *color))currentPageColor;

/// 页码非高亮图标
- (HHCustomPageControl *(^)(UIImage *image))pageImage;

/// 页码高亮图标
- (HHCustomPageControl *(^)(UIImage *image))currentPageImage;

/// 页码显示样式
- (HHCustomPageControl *(^)(HHPageControlType type))pageType;

/// 页码对齐方式
- (HHCustomPageControl *(^)(HHPageControlAlignment alignment))pageAlignment;

/// 页码高亮时放大
- (HHCustomPageControl *(^)(CGFloat scale))pageScale;

/// 页码序号是否显示
- (HHCustomPageControl *(^)(BOOL show))showPageIndex;

/// 页码序号非高亮时颜色
- (HHCustomPageControl *(^)(UIColor *color))pageIndexColor;

/// 页码序号高亮时颜色
- (HHCustomPageControl *(^)(UIColor *color))currentPageIndexColor;

/// 页码序号非高亮时字体大小
- (HHCustomPageControl *(^)(UIFont *font))pageIndexFont;

/// 页码高亮时字体大小
- (HHCustomPageControl *(^)(UIFont *font))currentPageIndexFont;

/// 页码间距
- (HHCustomPageControl *(^)(CGFloat margin))pageMarginX;

/// 页码高
- (HHCustomPageControl *(^)(CGFloat height))pageHeight;

/// 页码宽
- (HHCustomPageControl *(^)(CGFloat width))pageWidth;

/// 页码是否适配图标大小
- (HHCustomPageControl *(^)(BOOL autoresizing))autoresizingImage;

@end
