//
//  HHWebViewController.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/27.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHRootViewController.h"
#import <WebKit/WebKit.h>

@interface HHWebViewController : HHRootViewController

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic) UIColor *progressViewColor;
@property (nonatomic, weak) WKWebViewConfiguration *webConfiguration;
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithUrl:(NSString *)url;

//更新进度条
- (void)updateProgress:(double)progress;

//更新导航栏按钮，子类去实现
- (void)updateNavigationItems;

@end
