//
//  HHPromptBox.h
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPromptBox : UIView

- (instancetype)initCustomPromptBoxWithTitle:(NSString *)title contentStr:(NSString *)content andTop:(float)top alpha:(float)alpha;
//显示
- (void)showPromptBox:(BOOL)animated;
//隐藏
- (void)hidePromptBox:(BOOL)animated;

@end
