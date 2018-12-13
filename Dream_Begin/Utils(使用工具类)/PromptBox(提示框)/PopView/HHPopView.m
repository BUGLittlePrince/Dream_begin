//
//  HHPopView.m
//  Dream_Begin
//
//  Created by 韩宏 on 2018/11/27.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHPopView.h"
#import "UIDevice+HHPopViewExtension.h"

/** 手机屏 比例 */
#define kIphone6Width 375.0
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (Screen_Width*((x)/kIphone6Width))
#define UIColorFromR_G_B(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface HHPopView ()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation HHPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        // 单击的 Recognizer(_typeBottomView添加手势)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharePicCancelButtonAction)];
        tap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:tap];

        CGFloat top = [[UIDevice currentDevice] safeAreaTop] + [[UIDevice currentDevice] navigationBarHeight];
        self.alertView.frame = CGRectMake(kFit(75/2),  kFit(21) + top, Screen_Width -kFit(75), kFit(460 + 51));
        self.alertView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.alertView];

        [self createYTStsralertView];
    }
    return self;
}

- (void)setSharePictureImageUrlStr:(NSString *)sharePictureImageUrlStr
{
    _sharePictureImageUrlStr = sharePictureImageUrlStr;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:sharePictureImageUrlStr] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

    }];
}

- (void)createYTStsralertView {
    self.pictureImageView = [UIImageView new];
    self.pictureImageView.layer.cornerRadius = 10;
    self.pictureImageView.layer.masksToBounds = YES;
    [self.alertView addSubview:self.pictureImageView];
    self.pictureImageView.backgroundColor = [UIColor cyanColor];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.alertView);
        make.centerY.equalTo(self.alertView);
        make.width.equalTo(@(300));
        make.height.equalTo(@(400));
    }];

    //取消
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [self.pictureImageView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureImageView.mas_bottom).with.offset(-20);
        make.height.equalTo(@(40));
        make.width.equalTo(@(40));
        make.centerX.equalTo(self.pictureImageView);
    }];
    [self.cancelButton addTarget:self action:@selector(sharePicCancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma mark -------->取消Action
- (void)sharePicCancelButtonAction {
    [self dismissAlertView];
}

- (UIView *)alertView {
    if (_alertView == nil) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 0;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (void)show {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        strongSelf.backgroundColor = UIColorFromR_G_B(1, 1, 1, 0.3f);
        strongSelf.alertView.transform = transform;
        strongSelf.alertView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissAlertView {
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
    }];
}

@end
