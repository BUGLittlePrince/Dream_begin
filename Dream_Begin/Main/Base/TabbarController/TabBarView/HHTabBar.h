//
//  HHTabBar.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHTabBar;

@protocol HHTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(HHTabBar *)tabBar;

@end

@interface HHTabBar : UITabBar

@property (nonatomic, weak) id<HHTabBarDelegate> myDelegate;

@end
