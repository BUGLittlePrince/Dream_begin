//
//  HHPieChartView.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPieView.h"

@interface HHPieChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray <HHPieModel *> *)array;

@end
