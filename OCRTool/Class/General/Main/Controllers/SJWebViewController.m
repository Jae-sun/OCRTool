//
//  SJWebViewController.m
//
//  Created by Jaesun on 2018/11/19.
//  Copyright © 2018年 S.J. All rights reserved.
//

#import "SJWebViewController.h"

@interface SJWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@end

@implementation SJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置子视图
    [self configSubviews];
}

- (void)updateNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forBarMetrics:UIBarMetricsDefault];
}

// 设置子视图
- (void)configSubviews {
    // 网页配置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentControl = [[WKUserContentController alloc] init];
    // 子类中实现（javaScriptMessageNames） 获取当前webview 在原生页面获取的JavaScript方法
    NSArray *jsMessageNames = [self javaScriptMessageNames];
    if (jsMessageNames.count) {
        for (NSString *msgName in jsMessageNames) {
            // 注册JavaScript方法
            [userContentControl addScriptMessageHandler:self name:msgName];
        }
        config.userContentController = userContentControl;
    }
    // 初始化网页视图
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [self.view addSubview:self.webView];
    SJWeakSelf;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
}

// 加载webView
- (void)loadWebViewWithURL:(id)url {
    NSURL *loadURL = nil;
    // 对url进行检查
    if (!url) {
        return;
    }
    if ([url hasSuffix:@"html"]) { // 本地html
        NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:nil]; // 如果Bundle中没有该文件会返回nil
        if (!path) {
            NSLog(@"未查找到文件: %@",url);
            return;
        }
        loadURL = [NSURL fileURLWithPath:path];
    }
    else if ([url isKindOfClass:[NSURL class]]) { // URL
        loadURL = url;
    }
    else if ([url isKindOfClass:[NSString class]]) { // URL Stirng
        NSCharacterSet *URLCharSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        [url stringByAddingPercentEncodingWithAllowedCharacters:URLCharSet];
        loadURL = [NSURL URLWithString:url];
    }
    else {
        NSLog(@"格式错误：url- %@",url);
    }
    // 加载web页面
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:loadURL];
    [self.webView loadRequest:request];
}

#pragma mark- Delegate/Datasuorce

#pragma mark WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"页面关闭");
}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"当主框架的内容开始加载");
    [self webViewDidCommitNavigation];
}

// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    [self webViewLoadFinished];
}

// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
}

#pragma mark- WKScriptMessageHandler
// JavaScriptMessage时的回调方法（在HTML中的JavaScript代码调用注册的消息是回调）
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    [self handleJavaScriptMessage:message];
}

#pragma mark- 子类可重载方法
// 网页数据请求成功，页面开始加载
- (void)webViewDidCommitNavigation {
    
}

// 页面加载完成
- (void)webViewLoadFinished {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // UI更新
    });
}


#pragma mark JS-->OC
// 需要注册的消息名称
- (NSArray *)javaScriptMessageNames {
    return nil;
}

// 处理消息回调
- (void)handleJavaScriptMessage:(WKScriptMessage *)message {
    NSLog(@"Web页面点击了：%@ 方法",message.name);
}

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
- (void)evaluateJavaScript:(NSString *)JSFunction {
    [self.webView evaluateJavaScript:JSFunction completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 成功
            NSLog(@"%@",response);
        } else {
            // 失败
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}


@end
