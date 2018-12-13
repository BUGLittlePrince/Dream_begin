//
//  HHLoginFinishButton.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/28.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^finishBlock)(void);

@interface HHLoginFinishButton : UIView

@property (nonatomic, copy) finishBlock translateBlock;

@end
