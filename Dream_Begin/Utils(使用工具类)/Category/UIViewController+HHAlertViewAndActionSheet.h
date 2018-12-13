//
//  UIViewController+HHAlertViewAndActionSheet.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/24.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NO_USE -1000
typedef void (^click)(NSInteger index);
typedef void (^configuration)(UITextField *field, NSInteger index);
typedef void (^clickHaveField)(NSArray<UITextField *> *fields, NSInteger index);

@interface UIViewController (HHAlertViewAndActionSheet)

#ifdef kiOS8Later

#else
<
    UIAlertViewDelegate,
    UIActionSheetDelegate
>
#endif

- (void)AlertWithTitle:(NSString *)title
              memssage:(NSString *)message
             andOthers:(NSArray<NSString *> *)others
              animated:(BOOL)animated
                action:(click)click;


- (void)ActionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
                 destructive:(NSString *)destructive
           destructiveAction:(click)destructiveAction
                   andOthers:(NSArray<NSString *> *)others
                    animated:(BOOL)animated
                      action:(click)click;


- (void)AlertWithTitle:(NSString *)title
               message:(NSString *)message
               buttons:(NSArray<NSString *> *)buttons
       textFieldNumber:(NSInteger)number
         configuration:(configuration)configuration
              animated:(BOOL)animated
               actionn:(clickHaveField)click;

@end
