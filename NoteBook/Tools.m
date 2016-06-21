//
//  Tools.m
//  NoteBook
//
//  Created by Alvin on 16/6/13.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"

@implementation Tools

+ (void) closeApplication {
#if 0
    [[NSApplication sharedApplication] terminate:nil];
#else
    exit(0);
#endif
}

@end
