//
//  HHADPageView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    启动广告页面
 */
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

typedef void(^TapBlock)(void);

@interface HHADPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame wTapBlock:(TapBlock)tapBlock;
//显示广告页面方法
- (void)show;
//图片路径
@property (nonatomic, copy) NSString *filePath;

@end
