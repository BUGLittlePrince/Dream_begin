//
//  HHPageControl.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHPageControlDelegate;

@interface HHPageControl : UIControl

//遵循的类
@property (nonatomic) Class dotViewClass;
//pageControl小圆标的图片
@property (nonatomic) UIImage *dotImage;
//当前小圆标图片
@property (nonatomic) UIImage *currentDotImage;
//小圆标尺寸
@property (nonatomic) CGSize dotSize;
@property (nonatomic, strong) UIColor *dotColor;
//两个小圆标之间的间距，默认是8
@property (nonatomic) NSInteger spacingBetweenDots;

#pragma mark -- pageControl属性 --
@property (nonatomic, assign) id<HHPageControlDelegate>delegate;
@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL hidesForSinglePage;
@property (nonatomic) BOOL shouldResizeFromCenter;
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end

@protocol HHPageControlDelegate<NSObject>

@optional
- (void)HHPageControl:(HHPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;

@end
