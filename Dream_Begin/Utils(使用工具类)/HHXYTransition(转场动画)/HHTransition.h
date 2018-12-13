//
//  HHTransition.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTransition : NSObject<UIViewControllerAnimatedTransitioning>

//是否为push，反之则为pop
@property (nonatomic, assign) BOOL isPush;
//动画时长
@property (nonatomic, assign) NSTimeInterval animationDuration;

@end
