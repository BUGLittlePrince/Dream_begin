//
//  HHMyPlanDetailsVC.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBackStatu)(NSInteger statu);

@interface HHMyPlanDetailsVC : UIViewController

@property (nonatomic, assign) NSInteger statu;
@property (nonatomic, copy) callBackStatu block;

//- (void)callBackStatu;

@end
