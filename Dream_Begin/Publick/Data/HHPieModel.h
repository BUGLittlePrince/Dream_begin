//
//  HHPieModel.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HHPieModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;
//描述
@property (nonatomic, copy) NSString *descript;
//总数
@property (nonatomic, assign) CGFloat count;
//百分比
@property (nonatomic, assign) CGFloat percent;
//颜色
@property (nonatomic, strong) UIColor *color;

@end
