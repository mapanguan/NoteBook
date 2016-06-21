//
//  FactionVC.m
//  NoteBook
//
//  Created by Alvin on 16/6/15.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "FactionVC.h"
#import "Tools.h"
#import "DIYSheetVC.h"//自定义VC
#import "DIYWindows.h"//自定义窗口
#import "MyView.h"

@interface FactionVC ()<NSAlertDelegate,NSWindowDelegate>
{
    NSStatusItem* statusItem;
}

@end

@implementation FactionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark 显示“关于”界面
- (IBAction)showAbout:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp orderFrontStandardAboutPanel:self];
}


#pragma mark 创建状态栏的状态图标
- (IBAction)creatStatusBarItem:(id)sender {
    [self setUpStatusItem];//创建状态栏的状态图标
}

- (void)setUpStatusItem {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setImage:[NSImage imageNamed:@"贷款"]];
    [statusItem setHighlightMode:YES];
    [statusItem setAction:@selector(onStatusItemClicked:)];
    [statusItem setTarget:self];
}

//状态图标点击事件
- (void)onStatusItemClicked:(id)sender {
    [self showAlertView:nil];
}

#pragma mark 弹出视图
- (IBAction)showAlertView:(id)sender {

    NSAlert *alert = [[NSAlert alloc]init];
    alert.alertStyle = NSWarningAlertStyle;
    [alert setInformativeText:@"测试"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"去顶"];
    [alert addButtonWithTitle:@"hehehe"];
    [alert addButtonWithTitle:@"hahha"];

    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        NSLog(@"点击按钮返回的code%ld",(long)returnCode);
    }];
}
#pragma mark 关闭程序
- (IBAction)closeApp:(id)sender {
    [Tools closeApplication];
}

//跳转到自定义宽口
- (IBAction)alertDIYWindow:(id)sender {
    
    DIYWindows * wc = [[DIYWindows alloc]initWithWindowNibName:@"DIYWindows"];
    
#if 1
    //类似于alert弹出、需要取消两个选项
    [NSApp beginSheet: wc.window
       modalForWindow: self.view.window
     
        modalDelegate: nil
     
       didEndSelector:	@selector(didEndSheet:returnCode:contextInfo:)
     
          contextInfo: nil];
    
#else
    //模态跳转，跳出另外一个窗口，底部窗口无法获得点击事件。
    [NSApp runModalForWindow:[wc window]];
#endif
    
}

-(void)didEndSheet:(id)sheet returnCode:(NSString*)code contextInfo:(NSDictionary*)dic{
 
}

#pragma mark 跳转到自定义视图控制器
- (IBAction)sheettDIY_VC:(id)sender {
    DIYSheetVC * wc = [[DIYSheetVC alloc]initWithNibName:@"DIYSheetVC" bundle:nil];
    [self presentViewControllerAsSheet:wc];
}

#pragma mark 打开文件
- (IBAction)openFile:(id)sender {
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    // 第2行代码是设置默认的路径
//    [panel setDirectory:NSHomeDirectory()];
    [panel setDirectoryURL:[NSURL URLWithString:NSHomeDirectory()]];
    //第3行代码是设置不允许多选
    [panel setAllowsMultipleSelection:YES];
    //第4行代码是设置可以打开文件夹
    [panel setCanChooseDirectories:YES];
    //第5行代码是设置可以选中文件
    [panel setCanChooseFiles:YES];
    //第6行代码是设置可以打开的文件类型
    [panel setAllowedFileTypes:@[@"txt"]];
    //第8行代码是判断用户选中的是不是OK按钮
    [panel setAllowsOtherFileTypes:YES];
    if ([panel runModal] == NSOKButton) {
        NSString *path = [panel.URLs.firstObject path];
        NSLog(@"选择的文件路径是：%@",path);
        //code
    }
}

#pragma mark 弹出保存文件界面
- (IBAction)saveFile:(id)sender {
    //第2行代码是设置默认的文件名
    NSSavePanel*    panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@"Untitle.txt"];
    //第3行代码是设置提示信息
    [panel setMessage:@"选择路径保存文件"];
    [panel setAllowsOtherFileTypes:YES];
    //第5行代码是设置允许的文件类型
    [panel setAllowedFileTypes:@[@"txt"]];
    //第6行代码是隐藏扩展名
    [panel setExtensionHidden:YES];
    //第7行代码是设置可以创建文件
    [panel setCanCreateDirectories:YES];
    //第8 - 14行代码是运行窗口
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton)
        {
            //第11行代码是取出用户选择保存的路径
            NSString *path = [[panel URL] path];
            [@"txt" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    }];
}

#pragma mark 加载自定义View && 添加拖拽事件
- (IBAction)loadDIYView:(id)sender {
    //镜像视图
//    MyView *view = [[MyView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
     MyView *view = [[MyView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [self.view addSubview:view];
}

#pragma mark 颜色获取器
- (IBAction)pickColor:(id)sender {
    
    NSColorPanel* cp;
    cp = [NSColorPanel sharedColorPanel];
    [cp setDelegate:self];
    [cp setTarget:self];
    [cp setAction:@selector(changeColor:)];
    [cp setContinuous:YES];
    [NSApp runModalForWindow:cp];
    [cp orderOut:cp];
}

- (void)changeColor:(id)sender {
    NSColorPanel *pabel = sender;
    
    NSLog(@"%@",pabel.color);
}

- (void)windowWillClose:(NSNotification *)notification {
    
    [NSApp stopModalWithCode:0];
}



















@end
