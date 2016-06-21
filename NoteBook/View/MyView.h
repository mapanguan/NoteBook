//
//  MyView.h
//  NoteBook
//
//  Created by Alvin on 2016/6/19.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyView : NSView<NSDraggingDestination>{
    BOOL isDragIn;
}

@property (nonatomic, strong) IBOutlet NSView* view;
@property (strong) IBOutlet NSImageView *imgView;

@end
