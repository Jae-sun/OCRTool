//
//  SJWebViewController.h
//
//  Created by Jaesun on 2018/11/19.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJWebViewController : SJViewController
/** 网页视图 */
@property (nonatomic, strong) WKWebView *webView;
// 加载WebView
- (void)loadWebViewWithURL:(id)url;
// 网页数据请求成功，页面开始加载
- (void)webViewDidCommitNavigation;
// 页面加载完成
- (void)webViewLoadFinished;

#pragma mark JS-->OC
// 页面要添加的JavaScript消息名 （初始化webView时 JavaScript代码中注册对应的消息名，在js调用时会回调给原生界面）
- (NSArray *)javaScriptMessageNames;
// 对JavaScriptMessage 回调处理
- (void)handleJavaScriptMessage:(WKScriptMessage *)message;

#pragma mark OC-->JS
/**
 原生执行JavaScript方法 可以传参（如果为普通字符串要加 '',如果为JSON字符串不用）
 例如：
 NSArray *arr = @[@"A",@"A",@"A",@"A",@"A",@"A"];
 NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
 NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSString *javaScriptFunction = [NSString stringWithFormat:@"reportLoad(%@,%@)",jsonString,@"'abc'"];
 @param JSFunction 需要调用的参数
 */
- (void)evaluateJavaScript:(NSString *)JSFunction;

@end

NS_ASSUME_NONNULL_END
