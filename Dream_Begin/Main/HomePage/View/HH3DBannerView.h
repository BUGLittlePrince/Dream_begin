//
//  HH3DBannerView.h
//  无限轮播-背景虚化
//
//  Created by hanhong on 2018/3/14.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HH3DBannerView : UIView<UIScrollViewDelegate>

/*! 类说明
 * 图片间有间距，又要有翻页效果
 * @param imageSpacing 图片间间距
 * @param imageWidth 图片宽
 **/
+ (instancetype)initWithFrame:(CGRect)frame imageSpacing:(CGFloat)imageSpacing imageWidth:(CGFloat)imageWidth;

/*! 类说明
 * 图片间有间距，又要有翻页效果
 * @param imageSpacing 图片间间距
 * @param imageWidth 图片宽
 * @param data 数据
 **/
+ (instancetype)initWithFrame:(CGRect)frame imageSpacing:(CGFloat)imageSpacing imageWidth:(CGFloat)imageWidth data:(NSMutableArray *)data;

//点击中间图片的回调
@property (nonatomic, copy) void (^clickImageBlock)(NSInteger currentIndex);
//图片的圆角半径
@property (nonatomic, assign) CGFloat imageRadius;
//数据源
@property (nonatomic, strong) NSMutableArray *data;
/** 图片高度差，默认为0*/
@property (nonatomic, assign) CGFloat imageHeightPoor;
/** 初始alpha，默认1*/
@property (nonatomic, assign) CGFloat initAlpha;

/** 是否显示分页控件*/
@property (nonatomic, assign) BOOL showPageControl;
/** 当前小圆点颜色*/
@property (nonatomic, retain) UIColor *curPageControlColor;
/** 其余小圆点颜色*/
@property (nonatomic, retain) UIColor *otherPageControlColor;

/** 占位图*/
@property (nonatomic, strong) UIImage *placeHolderImage;
/** 是否在只有与一张图片的时候隐藏pageControl，默认为YES*/
@property (nonatomic) BOOL hidesForSinglePage;
/** 自动滚动时间间隔，默认2s*/
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否自动滚动，默认为YES*/
@property (nonatomic, assign) BOOL autoScroll;


@end
