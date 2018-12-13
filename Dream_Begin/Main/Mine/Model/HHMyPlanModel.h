//
//  HHMyPlanModel.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/22.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHMyPlanModel : NSObject

//是否选中
@property (nonatomic, assign) BOOL isSelected;
//是否完成
@property (nonatomic, assign) BOOL isComplete;
//第几项任务
@property (nonatomic, copy) NSString *text;
//图片
@property (nonatomic, strong) UIImage *image;
//状态
@property (nonatomic, copy) NSString *statu;

@end
