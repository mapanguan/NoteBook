//
//  MyView.m
//  NoteBook
//
//  Created by Alvin on 2016/6/19.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    if (isDragIn)
    {
        NSColor* color = [NSColor colorWithRed:220.0 / 255 green:220.0 / 255 blue:220.0 / 255 alpha:1.0];
        [color set];
        NSBezierPath* thePath = [NSBezierPath bezierPath];
        [thePath appendBezierPathWithRoundedRect:dirtyRect xRadius:8.0 yRadius:8.0];
        [thePath fill];
    }
}

- (IBAction)removeSelf:(id)sender {
    [self removeFromSuperview];
}


-(instancetype)initWithFrame:(NSRect)frameRect{

    NSString* nibName = NSStringFromClass([self class]);
    self = [super initWithFrame:frameRect];
    if (self) {
        if ([[NSBundle mainBundle] loadNibNamed:nibName
                                          owner:self
                                topLevelObjects:nil]) {
            [self.view setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            
            [self addSubview:self.view];
            
            //注册拖拽事件
            [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
        }
    }
    return self;

}



//注意NSView派生自NSResponder。

- (void)mouseDown:(NSEvent *)event{
    
    unsigned int flags;
    flags = [event modifierFlags];
    if (flags & NSControlKeyMask) {
        //...handle control click...
    }
    if (flags & NSShiftKeyMask) {
        //...handle shift click...
    }
    
    NSLog(@"mouseDown: %ld", (long)[event clickCount]);
    
    
}
- (void)rightMouseDown:(NSEvent *)event{
    
}
- (void)otherMouseDown:(NSEvent *)event{
    
}

- (void)mouseUp:(NSEvent *)event{
    
    NSLog(@"mouseUp:");
    
}
- (void)rightMouseUp:(NSEvent *)event{
    
}
- (void)otherMouseUp:(NSEvent *)event{
    
}

- (void)mouseDragged:(NSEvent *)event{
    
    NSPoint p = [event locationInWindow];
    NSLog(@"mouseDragged:%@", NSStringFromPoint(p));
    
}
- (void)scrollWheel:(NSEvent *)event{
    
}
- (void)rightMouseDragged:(NSEvent *)event{
    
}
- (void)otherMouseDragged:(NSEvent *)event{
    
    
}


#pragma mark - Destination Operations

//拖动进入
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    isDragIn = YES;
    [self setNeedsDisplay:YES];
    return NSDragOperationCopy;
}

//拖动退出
- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    isDragIn = NO;
    [self setNeedsDisplay:YES];
}

//已放入区域
- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    isDragIn = NO;
    [self setNeedsDisplay:YES];
    return YES;
}

//执行拖动操作
- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    if ([sender draggingSource] != self)
    {
        NSArray* filePaths = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
        [self.imgView setImage:[[NSImage alloc]initWithContentsOfFile:filePaths.lastObject]];
    }
    
    return YES;
}


@end
