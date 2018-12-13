//
//  HHWebViewController.m
//  Dream_Begin
//
//  Created by hanhong on 2018/4/27.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHWebViewController.h"
#import "HHJSHandler.h"
#import "HHHeaderModel.h"
#import "HHAESCipher.h"
//#import "YYKit.h"

@interface HHWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) HHJSHandler *jsHandler;
//上次进度条的位置
@property (nonatomic, assign) double lastProgress;

@end

@implementation HHWebViewController

- (instancetype)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        self.url = url;
        _progressViewColor = [UIColor colorWithHexString:@"0485d1"];
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
        //加密header部分
        NSString *headerContentStr = [[HHHeaderModel new] modelToJSONString];
        NSString *headerAESStr = aesEncrypt(headerContentStr);
        [request setValue:headerAESStr forHTTPHeaderField:@"header-encrypt-code"];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
    
    //适配iOS11
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark -- 初始化webView --
- (void)initWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //打开JS交互
    configuration.preferences.javaScriptEnabled = YES;
    _webConfiguration = configuration;
    _jsHandler = [[HHJSHandler alloc] initWithViewController:self configuration:configuration];
    
    CGRect frame = self.view.bounds;
    if (self.navigationController && self.isHidenNaviBar == NO) {
        frame = CGRectMake(0, 0, self.view.bounds.size.width, KScreenHeight - kTopHeight);
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    //打开网页间的滑动返回
    _webView.allowsBackForwardNavigationGestures = YES;
    //监控进度
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    
    //进度条
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.tintColor = _progressViewColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [_webView addSubview:_progressView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    //加密header部分
    NSString *headerContentStr = [[HHHeaderModel alloc] modelToJSONString];
    NSString *headerAESStr = aesEncrypt(headerContentStr);
    [request setValue:headerAESStr forHTTPHeaderField:@"header-encrypt-code"];
    [_webView loadRequest:request];
}

- (void)backButtonClicked
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [super backBtnClicked];
    }
}

- (void)backBtnClicked
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [super backBtnClicked];
    }
}

#pragma mark -- 进度条 --
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updateProgress:_webView.estimatedProgress];
}

#pragma mark -- 更新进度条 --
- (void)updateProgress:(double)progress
{
    self.progressView.alpha = 1;
    if (progress > _lastProgress) {
        //WKWebView有一个属性estimatedProgress，就是当前网页加载的进度
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    } else {
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            _lastProgress = 0;
        });
    }
}

#pragma mark -- navigation delegate -
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.title = webView.title;
    [self updateProgress:webView.estimatedProgress];
    [self updateNavigationItems];
}

//子类去实现
- (void)updateNavigationItems
{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    //更新返回按钮
    [self updateNavigationItems];
    
    NSURL *url = webView.URL;
    
    //打开WKWebView禁用了电话和跳转App Store，通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_jsHandler cancelHandler];
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
