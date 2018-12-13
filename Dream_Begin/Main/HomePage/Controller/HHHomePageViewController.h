//
//  HHHomePageViewController.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/26.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHRootViewController.h"
#import "HHHomePageLogic.h"
#import "HHHomeLunBoLogic.h"

@interface HHHomePageViewController : HHRootViewController

@property (nonatomic, strong) HHHomePageLogic *logic;
@property (nonatomic, strong) HHHomeLunBoLogic *lunBoLogic;

@end
