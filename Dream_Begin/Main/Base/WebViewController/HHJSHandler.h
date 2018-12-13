//
//  HHJSHandler.h
//  Dream_Begin
//
//  Created by hanhong on 2018/4/27.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface HHJSHandler : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak, readonly) UIViewController *webVC;
//网页配置
@property (nonatomic, strong, readonly) WKWebViewConfiguration *configuration;

- (instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;
//关闭处理程序
- (void)cancelHandler;

@end
