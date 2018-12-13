//
//  HHXYTransitionProtocol.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/18.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HHXYTransitionProtocol <NSObject>

@optional
/**
    转场动画的目标view，需要转场动画的对象必须实现该方法并返回要做动画的view
    @return view
 */
- (UIView *)targetTransitionView;

/**
    是否需要实现转场效果，不需要转场动画可不实现，需要必须实现并返回YES
    return 是否
 */
- (BOOL)isNeedTransition;

@end
