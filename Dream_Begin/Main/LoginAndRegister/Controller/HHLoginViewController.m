//
//  HHLoginViewController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/27.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHLoginViewController.h"
#import "HHTextField.h"
#import "HHLoginFinishButton.h"
#import "HHRootViewController.h"

@interface HHLoginViewController ()

@property (nonatomic, strong) HHLoginFinishButton *login;

@end

@implementation HHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.isHidenNaviBar = YES;
//    [self.view.layer addSublayer:[self backgroundLayer]];
    
    //设置背景图片
    NSString *path = [[NSBundle mainBundle] pathForResource:@"login_bg" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.view.layer.contents = (id)image.CGImage;
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isHidenNaviBar = YES;
    [self setUp];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)setUp
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    titleLabel.center = CGPointMake(self.view.center.x, 170);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"追梦赤子心";
    titleLabel.font = [UIFont systemFontOfSize:40.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 350, 30)];
    detailLabel.center = CGPointMake(self.view.center.x, 80);
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.text = @"因为梦想，所以选择远方。因为无所依靠，所以必须坚强";
    detailLabel.font = [UIFont systemFontOfSize:13.f];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailLabel];
    
    HHTextField *userName = [[HHTextField alloc] initWithFrame:CGRectMake(0, 0, 270, 30)];
    userName.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.7);
    userName.hh_placeholder = @"用户名";
    userName.placeholderSelectStateColor = [UIColor lightGrayColor];
    userName.tag = 0;
    [self.view addSubview:userName];
    
    HHTextField *pwd = [[HHTextField alloc] initWithFrame:CGRectMake(0, 0, 270, 30)];
    pwd.center = CGPointMake(self.view.center.x, userName.center.y + 80);
    pwd.hh_placeholder = @"密码";
    pwd.placeholderSelectStateColor = [UIColor lightGrayColor];
    pwd.tag = 1;
    pwd.isSecureTextEntry = YES;
    [self.view addSubview:pwd];
    
    HHLoginFinishButton *login = [[HHLoginFinishButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    login.center = CGPointMake(self.view.center.x, pwd.center.y + 100);
    [self.view addSubview:login];
    _login = login;
    
    __block HHLoginFinishButton *button = login;
    login.translateBlock = ^{
        HHLog(@"跳转了");
        button.bounds = CGRectMake(0, 0, 44, 44);
        button.layer.cornerRadius = 22;
        KPostNotification(KNotificationLoginStateChange, @YES);
    };
}

//键盘回收
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    for (UIView *view in self.view.subviews) {
//        [view resignFirstResponder];
//    }
    [self.view endEditing:YES];
}

//移动view
- (void)transformView:(NSNotification *)notification
{
    //获取键盘弹出前的rect
    NSValue *keyBoardBeginBounds = [[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的rect
    NSValue *keyBoardEndBounds = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY = endRect.origin.y - beginRect.origin.y;
    HHLog(@"键盘的上移距离为：%f", deltaY);
    
    //在0.25s内完成self.view的frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.origin.y + deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

#pragma mark -- 做背景渐变色--
//- (CAGradientLayer *)backgroundLayer
//{
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.view.bounds;
//    gradientLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]].CGColor;
//    gradientLayer.startPoint = CGPointMake(0.5, 0);
//    gradientLayer.endPoint = CGPointMake(0.5, 1);
//    gradientLayer.locations = @[@0.65, @1];
//    return gradientLayer;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
