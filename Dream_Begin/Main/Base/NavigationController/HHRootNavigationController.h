//
//  HHRootNavigationController.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    导航控制器基类
 */

@interface HHRootNavigationController : UINavigationController

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated 是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
