//
//  FeedbackVC.m
//  NoteBook
//
//  Created by Alvin on 16/6/9.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.juhua startAnimation:self];
}

-(void)viewWillDisappear{

    [self.juhua stopAnimation:self];
}




@end
