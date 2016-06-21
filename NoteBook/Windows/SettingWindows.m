//
//  SettingWindows.m
//  NoteBook
//
//  Created by Alvin on 16/6/9.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "SettingWindows.h"
#import "FeedbackVC.h"
#import "InvalidPeopleVC.h"
#import "SettingVC.h"
#import "CuculateVC.h"

@interface SettingWindows ()

@end

@implementation SettingWindows

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (IBAction)aboutMe:(id)sender {
    
//    AboutusVC *avc =  [self.storyboard instantiateControllerWithIdentifier:@"AboutusVC"];
//    self.window.contentViewController = avc;
}

- (IBAction)setting:(id)sender {
    SettingVC *svc = [[SettingVC alloc]initWithNibName:@"SettingVC" bundle:nil];
    self.window.contentViewController = svc;
}

- (IBAction)caculate:(id)sender {
    CuculateVC *cvc = [[CuculateVC alloc]initWithNibName:@"CuculateVC" bundle:nil];
    self.window.contentViewController = cvc;
}

- (IBAction)feedback:(id)sender {
    FeedbackVC *fvc = [[FeedbackVC alloc]initWithNibName:@"FeedbackVC" bundle:nil];
    self.window.contentViewController = fvc;
    
}
- (IBAction)invateSB:(id)sender {
    InvalidPeopleVC *ivc = [[InvalidPeopleVC alloc]initWithNibName:@"InvalidPeopleVC" bundle:nil];
    self.window.contentViewController = ivc;
}

@end
