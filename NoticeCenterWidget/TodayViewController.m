//
//  TodayViewController.m
//  NoticeCenterWidget
//
//  Created by Alvin on 2016/6/21.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler {
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you
    completionHandler(NCUpdateResultNoData);
}

- (IBAction)close:(id)sender {
    exit(0);
}
@end

