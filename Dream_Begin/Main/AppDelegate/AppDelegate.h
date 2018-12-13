//
//  AppDelegate.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHMainTabBarController.h"

/**
    制作调用，具体实现放到AppDelegate+AppService，或者Manager里面，防止代码过多不清晰
 */

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) HHMainTabBarController *mainTabBar;

@end

