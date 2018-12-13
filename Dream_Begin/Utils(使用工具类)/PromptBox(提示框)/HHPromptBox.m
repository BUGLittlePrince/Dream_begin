//
//  HHPromptBox.m
//  Dream_Begin
//
//  Created by 韩宏 on 2018/8/23.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHPromptBox.h"

@interface HHPromptBox()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation HHPromptBox

- (instancetype)initCustomPromptBoxWithTitle:(NSString *)title contentStr:(NSString *)content andTop:(float)top alpha:(float)alpha
{
    if (self = [super init]) {
        CGFloat titleH = 16;
        CGFloat contentH = 30;
        CGFloat selfH = 65;
        self.frame = CGRectMake(76, top, KScreenWidth - 76 * 2, selfH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:self];

        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(13);
            make.right.mas_offset(-13);
            make.height.mas_offset(titleH);
        }];
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;


        self.contentLabel = [[UILabel alloc]init];
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.right.mas_offset(-13);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(4.5);
            make.height.mas_offset(contentH);
        }];
        self.contentLabel.text = content;
        self.contentLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.numberOfLines = 0;
    }
    return self;
}

- (void)showPromptBox:(BOOL)animated
{
    if (animated)
    {
        self.transform = CGAffineTransformMakeScale(0.6f , 0.6f);
        self.alpha = 0.0f;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.transform = CGAffineTransformIdentity;
            weakSelf.alpha = 1.0f;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hidePromptBox:YES];
            });
        }];
    }
}

- (void)hidePromptBox:(BOOL)animated
{
    [self endEditing:YES];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(0.6f , 0.6f);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
