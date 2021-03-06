//
//  UIButton+HHButton.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/24.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "UIButton+HHButton.h"

@implementation UIButton (HHButton)

- (void)setBlock:(void (^)(UIButton *))block
{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void (^)(UIButton *))block
{
    return objc_getAssociatedObject(self, @selector(block));
}

- (void)addTapBlock:(void (^)(UIButton *))block
{
    self.block = block;
    [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(UIButton *)btn
{
    if (self.block) {
        self.block(btn);
    }
}

@end
