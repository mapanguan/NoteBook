//
//  SettingVC.m
//  NoteBook
//
//  Created by Alvin on 16/6/11.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "SettingVC.h"
#import <WebKit/WebKit.h>

@interface SettingVC (){

    IBOutlet WebView *webView;
}

@end

@interface WebViewController : NSObject<WebFrameLoadDelegate>{

  IBOutlet WebView* webView;
}

@end


@implementation WebViewController

+(NSString*)webScriptNameForSelector:(SEL)sel
{
    if(sel == @selector(Writelog:)) //JS对应的本地函数
        return @"log"; // 要注册的JS函数名
    else if(sel == @selector(alert:))
        return @"alert";
    return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel
{
    if(sel == @selector(Writelog:))//JS对应的本地函数
        return NO;
    else if(sel == @selector(alert:))
        return NO;
    return YES; //返回 YES 表示函数被排除，不会在网页上注册
}

- (void)awakeFromNib //当 WebContoller 加载完成后执行的动作
{
    [webView setFrameLoadDelegate:self];
    
    [[webView mainFrame] loadHTMLString:@"<button onclick=\"window.external.alert('This is an alert!!');\">Alert</button> <button onclick=\"window.external.log('lllllaaaa');\">Log</button>" baseURL:nil];
//    网页内容，两个按钮 一个弹出消息框，一个在控制台 Log
//     webView.mainFrameURL = @"http://someurl"; //加载网页
}

- (void)Writelog:(NSString*) txt
{
    NSLog(@"Log:%@",txt);
}

- (void)alert:(NSString*) txt
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"来自网页的消息"];
    [alert setInformativeText:txt];
    [alert runModal];
}

- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowScriptObject forFrame:(WebFrame *)frame //网页加载完成后发生的动作
{
    [windowScriptObject setValue:self forKeyPath:@"window.external"]; // 注册一个 window.external 的 Javascript 类
}

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
