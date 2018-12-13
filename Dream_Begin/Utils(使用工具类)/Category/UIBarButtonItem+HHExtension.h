//
//  UIBarButtonItem+HHExtension.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/25.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HHExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
