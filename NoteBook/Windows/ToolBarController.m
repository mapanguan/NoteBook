//
//  ToolBarController.m
//  NoteBook
//
//  Created by iosDev1-mapanguan on 16/5/20.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "ToolBarController.h"
#import "ViewController.h"

@interface ToolBarController ()

@end

@implementation ToolBarController

- (void)windowDidLoad {
    [super windowDidLoad];

}


- (BOOL) validateToolbarItem: (NSToolbarItem *) toolbarItem {

    return YES;

}

- (IBAction)chnageVC:(id)sender {
    ViewController*vc = [self.storyboard instantiateControllerWithIdentifier:@"ViewController"];
    [self.window setContentViewController:vc];
}

- (IBAction)zahofangAction:(id)sender {
     NSViewController*vc = [self.storyboard instantiateControllerWithIdentifier:@"cheshi"];
    [self.window setContentViewController:vc];
}

@end
