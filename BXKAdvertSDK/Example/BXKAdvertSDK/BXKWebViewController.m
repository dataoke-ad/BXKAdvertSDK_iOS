//
//  BXKWebViewController.m
//  BXKAdvertSDK_Example
//
//  Created by wit on 2020/8/26.
//  Copyright © 2020 Dataoke. All rights reserved.
//

#import "BXKWebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>


// MARK: - Important Message

/// 由于 iOS 的 WkWebview 对 js window.open 方法进行了安全限制，即调用该方法，不会起到作用。
/// 需要参考demo
/// 实现 WKUIDelegate 中的 webView(_:createWebViewWith:for:windowFeatures:) 处理请求拦截，
/// 实现 WKNavigationDelegate 中的 shouldOpenAction(_:) 处理淘宝跳转。
///
/// 除此之外，您也可以集成阿里百川处理应用间跳转，让用户获得更好的体验。
/// 阿里百川：https://baichuan.taobao.com

@interface BXKWebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation BXKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    if (self.URLString.length == 0) {
        return;
    }
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark -  WKUIDelegate

// MARK: 由于 iOS 的 WkWebview 对 js window.open 方法进行了安全限制，即调用该方法，不会起到作用。
// MARK: 需要参考demo
// MARK: 实现 WKUIDelegate 中的 webView(_:createWebViewWith:for:windowFeatures:) 处理请求拦截，

/// 处理请求拦截
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (navigationAction.targetFrame.isMainFrame != true) {
//        [webView loadRequest:navigationAction.request];
        BXKWebViewController *vc = [[BXKWebViewController alloc] init];
        vc.URLString = navigationAction.request.URL.absoluteString;
        [self.navigationController pushViewController:vc animated:YES];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"%@", prompt);
    completionHandler(nil);
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
    return NO;
}

#pragma mark -  WKNavigationDelegate

// MARK: 实现 WKNavigationDelegate 中的 shouldOpenAction(_:) 处理淘宝跳转

/// 处理跳转
- (BOOL)shouldOpenAction:(WKNavigationAction *)action {
    NSString *urlStr = action.request.URL.absoluteString;
    
    if ([urlStr hasPrefix:@"http://index.php"]) return false;
    
    if ([urlStr hasPrefix:@"tbopen://"] ||          // 跳转手机淘宝
        [urlStr hasPrefix:@"itms-apps"] ||          // 跳转App Store
        [urlStr hasPrefix:@"itunes.apple.com/app"]) {
        NSURL *url = [NSURL URLWithString:urlStr];
        if (url && [UIApplication.sharedApplication canOpenURL:url]) {
            [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
            return false;
        }
    }
    
    return true;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (![self shouldOpenAction:navigationAction]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    self.navigationItem.title = webView.title;
    self.title = webView.title;
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@", error.localizedRecoverySuggestion);
}

@end
