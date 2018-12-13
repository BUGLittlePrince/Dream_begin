//
//  HHAppManager.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    包含应用层的相关服务
 */

@interface HHAppManager : NSObject

#pragma mark -- APP启动接口 --
+ (void)appStart;

#pragma mark -- FPS监测 --
+ (void)showFPS;

@end
