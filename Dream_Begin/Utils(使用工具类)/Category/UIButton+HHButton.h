//
//  UIButton+HHButton.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/24.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HHButton)

@property (nonatomic, copy) void(^block)(UIButton *);

- (void)addTapBlock:(void(^)(UIButton *btn))block;

@end
