//
//  HHCollectionViewCell.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, copy) NSString *title;

/** 字体颜色*/
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/** 字体尺寸*/
@property (nonatomic, strong) UIFont *titleLabelTextFont;
/** 标签背景颜色*/
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
/** 标签高度*/
@property (nonatomic, assign) CGFloat titleLabelHeight;
/** 文字对齐*/
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;

/** 配置*/
@property (nonatomic, assign) BOOL hasConfigured;

/** 只展示文字轮播*/
@property (nonatomic, assign) BOOL onlyDisplayText;

@end
