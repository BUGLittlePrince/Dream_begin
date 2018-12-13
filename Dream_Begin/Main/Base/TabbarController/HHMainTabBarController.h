//
//  HHMainTabBarController.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    底部 TabBar 控制器
 */

@interface HHMainTabBarController : UITabBarController

/**
 *  设置小红点
 *  @param index tabbar下标
 *  @param isShow 是显示还是隐藏
 */
- (void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;

@end
