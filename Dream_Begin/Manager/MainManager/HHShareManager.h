//
//  HHShareManager.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    分享 相关服务
 */

@interface HHShareManager : NSObject

//单例
SINGLETON_FOR_HEADER(HHShareManager)

//展示分享页面
- (void)showShareView;

@end
