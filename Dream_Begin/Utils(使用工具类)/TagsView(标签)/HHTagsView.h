//
//  HHTagsView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHTagsView;

typedef void(^tagBtnClicked)(HHTagsView *aTagsView, UIButton *sender, NSInteger tag);

//配置
@interface HHTagsViewConfig : NSObject

//item之间的左右间距
@property (nonatomic) CGFloat itemHerMargin;
//item之间的上线间距
@property (nonatomic) CGFloat itemVerMargin;
//item高度
@property (nonatomic) CGFloat itemHeight;
//item标题距左右边缘的距离
@property (nonatomic) CGFloat itemContentEdgs;
//最顶部和最底部的item距离父视图顶部和底部的距离(无间距时可设置为0.1)
@property (nonatomic) CGFloat topBottomSpace;

//字体大小 默认为12
@property (nonatomic) CGFloat fontSize;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *normalBgImage;
@property (nonatomic, strong) UIImage *selectedBgImage;

//是否有边框，默认没有边框
@property (nonatomic) BOOL hasBorder;
@property (nonatomic) CGFloat borderRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat borderColor;

//是否可以选中，默认为NO(YES时是单选)
@property (nonatomic) BOOL isCanSelected;
//是否可以取消选中
@property (nonatomic) BOOL isCanCancelSelected;

//是否多选
@property (nonatomic) BOOL isMulti;
//单个选中对应的标题(初始化时默认选中的)
@property (nonatomic, copy) NSString *singleSelectedTitle;
//多个选中对应的标题数组(初始化时默认选中的)
@property (nonatomic, copy) NSArray *selectedDefaultTags;

@end

@interface HHTagsView : UIView

//点击回调
@property (nonatomic, copy) tagBtnClicked tagBtnClickBlock;
@property (nonatomic, strong) UIImageView *bgImageView;
//对应单选，当前选中的tag按钮
@property (nonatomic, strong) UIButton *selectedBtn;
//多个选中对应的标题数组
@property (nonatomic, copy) NSMutableArray *mutiSelectedTags;
/**
    必须给父视图设置一个高度
 */
- (instancetype)initWithFrame:(CGRect)frame tagsArray:(NSArray *)tagsArray config:(HHTagsViewConfig *)config;
- (CGFloat)heightTagsArray:(NSArray *)tagsArray config:(HHTagsViewConfig *)config;

@end
