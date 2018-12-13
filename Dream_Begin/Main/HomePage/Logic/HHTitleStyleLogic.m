//
//  HHTitleStyleLogic.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/8.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHTitleStyleLogic.h"

@implementation HHTitleStyleLogic

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isTitleViewScrollEnable = YES;
        self.isContentViewScrollEnable = YES;
        self.normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        self.selectedColor = CNavBgColor;
        self.font = [UIFont systemFontOfSize:14.0];
        self.titleMargin = 0.0;
        self.isShowBottomLine = YES;
        self.bottomLineColor = CNavBgColor;
        self.bottomLineH = 3.0;
        self.isNeedScale = YES;
        self.scaleRange = 1.2;
        self.isShowCover = NO;
        self.coverBgColor = [UIColor yellowColor];
        self.coverH = 25.0;
        self.coverMargin = 0.0;
        self.coverRadius = 5;
    }
    return self;
}

@end
