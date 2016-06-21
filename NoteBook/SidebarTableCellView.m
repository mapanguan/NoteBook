//
//  SidebarTableCellView.m
//  NoteBook
//
//  Created by iosDev1-mapanguan on 16/5/18.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "SidebarTableCellView.h"

@implementation SidebarTableCellView

-(void)awakeFromNib{

[[self.button cell] setBezelStyle:NSInlineBezelStyle];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    
    [self.button sizeToFit];
    
    NSRect textFrame = self.textField.frame;
    NSRect buttonFrame = self.button.frame;
    buttonFrame.origin.x = NSWidth(self.frame) - NSWidth(buttonFrame);
    self.button.frame = buttonFrame;
    textFrame.size.width = NSMinX(buttonFrame) - NSMinX(textFrame);
    self.textField.frame = textFrame;
}

@end
