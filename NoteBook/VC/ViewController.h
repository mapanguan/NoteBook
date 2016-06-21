//
//  ViewController.h
//  NoteBook
//
//  Created by iosDev1-mapanguan on 16/5/18.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController {
@private
    NSWindow *_window;

    __weak IBOutlet NSView *_mainContentView;
    __weak IBOutlet NSOutlineView *_sidebarOutlineView;

    NSViewController *_currentContentViewController;
    NSMutableDictionary *_childrenDictionary;
}

@property(nonatomic)NSArray *topLevelItems;

@end
