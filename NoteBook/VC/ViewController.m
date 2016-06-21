//
//  ViewController.m
//  NoteBook
//
//  Created by iosDev1-mapanguan on 16/5/18.
//  Copyright © 2016年 iosDev1-mapanguan. All rights reserved.
//

#import "ViewController.h"
#import "SidebarTableCellView.h"
#import "DIYSheetVC.h"
#import "DIYWindows.h"
#import "Tools.h"


@interface ViewController ()<NSApplicationDelegate, NSOutlineViewDelegate, NSOutlineViewDataSource, NSMenuDelegate>{

    NSArray *mainArr;
    NSArray *findHouseArr;
    NSArray *attentionArr;
    NSArray *mySpaceArr;

}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 菜单栏数组
    _topLevelItems = @[@"首页", @"找房", @"消息", @"我的空间"];
    
    mainArr = [NSArray arrayWithObjects:@"地铁房", @"学区房", @"精装修",@"品牌地产", nil];
    findHouseArr = [NSArray arrayWithObjects:@"地区1", @"地区2", @"地区3", nil];
    attentionArr = [NSArray arrayWithObjects:@"约看提醒",@"楼盘动态",@"楼盘推荐",@"楼盘活动",@"系统消息", nil];
    mySpaceArr =[NSArray arrayWithObjects:@"爱家基金", @"我的咨询", @"我的需求", @"我的看房团", @"我的预约",@"我的优惠",@"邀请好友",@"用户反馈", nil];
    
    
    
    _childrenDictionary = [NSMutableDictionary dictionary];
    [_childrenDictionary setObject:mainArr forKey:@"首页"];
    [_childrenDictionary setObject:findHouseArr forKey:@"找房"];
    [_childrenDictionary setObject:attentionArr forKey:@"消息"];
    [_childrenDictionary setObject:mySpaceArr forKey:@"我的空间"];
    
    // The basic recipe for a sidebar. Note that the selectionHighlightStyle is set to NSTableViewSelectionHighlightStyleSourceList in the nib
    [_sidebarOutlineView sizeLastColumnToFit];
    [_sidebarOutlineView reloadData];
    [_sidebarOutlineView setFloatsGroupRows:NO];
    
    _sidebarOutlineView.delegate = self;
    _sidebarOutlineView.dataSource = self;
    
    // NSTableViewRowSizeStyleDefault should be used, unless the user has picked an explicit size. In that case, it should be stored out and re-used.
    [_sidebarOutlineView setRowSizeStyle:NSTableViewRowSizeStyleDefault];
    
    // Expand all the root items; disable the expansion animation that normally happens
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0];
    [_sidebarOutlineView expandItem:nil expandChildren:YES];
    [NSAnimationContext endGrouping];
}


//cell点击事件
- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    if ([_sidebarOutlineView selectedRow] != -1) {
        NSString *item = [_sidebarOutlineView itemAtRow:[_sidebarOutlineView selectedRow]];
        if ([_sidebarOutlineView parentForItem:item] != nil) {
            // Only change things for non-root items (root items can be selected, but are ignored)
            [self _setContentViewToName:item];
        }
    }
}


//点击事件——切换不同的视图
- (void)_setContentViewToName:(NSString *)name {
    if (_currentContentViewController) {
        [[_currentContentViewController view] removeFromSuperview];
    }
    _currentContentViewController = [[NSViewController alloc] initWithNibName:name bundle:nil]; // Retained
    NSView *view = [_currentContentViewController view];
    view.frame = _mainContentView.bounds;
    [view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [_mainContentView addSubview:view];
}


//根据item返回不同层级的数组类容
- (NSArray *)_childrenForItem:(id)item {
    NSArray *children;
    if (item == nil) {
        children = _topLevelItems;
    } else {
        children = [_childrenDictionary objectForKey:item];
    }
    return children;
}


-(CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item{

    return 50;
}

//
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return [[self _childrenForItem:item] objectAtIndex:index];
}


- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    if ([outlineView parentForItem:item] == nil) {
        return YES;
    } else {
        return NO;
    }
}


//返回多少组
- (NSInteger) outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return [[self _childrenForItem:item] count];
}

//每组多少个
- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return [_topLevelItems containsObject:item];
}


- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item {
    // As an example, hide the "outline disclosure button" for FAVORITES. This hides the "Show/Hide" button and disables the tracking area for that row.
    if ([item isEqualToString:@"Favorites"]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    if ([_topLevelItems containsObject:item]) {//headerCell
        NSTableCellView *result = [outlineView makeViewWithIdentifier:@"HeadCell" owner:self];
        NSTextField*tf = result.textField;
        NSString *value = [item uppercaseString];
        [tf setStringValue:value];
        result.backgroundStyle = NSBackgroundStyleLowered;
        return result;
    } else  {

        SidebarTableCellView *result = [outlineView makeViewWithIdentifier:@"MainCell" owner:self];
        result.textField.stringValue = item;
        // Setup the icon based on our section
        id parent = [outlineView parentForItem:item];
        NSInteger index = [_topLevelItems indexOfObject:parent];
        
        NSImage*img = [NSImage imageNamed:item];
        if (img) {
            
            result.imageView.image = img;
        }else{
         
            result.imageView.image = [NSImage imageNamed:NSImageNameIconViewTemplate];
            
        }
        
//        NSInteger iconOffset = index % 4;
//        switch (iconOffset) {
//            case 0: {
//                result.imageView.image = [NSImage imageNamed:NSImageNameIconViewTemplate];
//                break;
//            }
//            case 1: {
//                result.imageView.image = [NSImage imageNamed:NSImageNameHomeTemplate];
//                break;
//            }
//            case 2: {
//                result.imageView.image = [NSImage imageNamed:NSImageNameQuickLookTemplate];
//                break;
//            }
//            case 3: {
//                result.imageView.image = [NSImage imageNamed:NSImageNameSlideshowTemplate];
//                break;
//            }
//        }
        BOOL hideUnreadIndicator = YES;
        // 设置未读提示按钮
        if (index == 0) {//作为一个文本框显示出来
            hideUnreadIndicator = NO;
            [result.button setTitle:@"42"];
            [result.button sizeToFit];
            [[result.button cell] setHighlightsBy:0];
        } else if (index == 2) {//第二组可点击按钮
            hideUnreadIndicator = NO;
            result.button.target = self;
            result.button.action = @selector(buttonClicked:);
            [result.button setImage:[NSImage imageNamed:NSImageNameAddTemplate]];
            [[result.button cell] setHighlightsBy:NSPushInCellMask|NSChangeBackgroundCellMask];
        }
        [result.button setHidden:hideUnreadIndicator];
        return result;
    }
}


- (void)buttonClicked:(id)sender {
    NSInteger row = [_sidebarOutlineView rowForView:sender];
    NSLog(@"row: %ld", row);
}

- (IBAction)sidebarMenuDidChange:(id)sender {
    // Allow the user to pick a sidebar style
    NSInteger rowSizeStyle = [sender tag];
    [_sidebarOutlineView setRowSizeStyle:rowSizeStyle];
}

- (void)menuNeedsUpdate:(NSMenu *)menu {
    for (NSInteger i = 0; i < [menu numberOfItems]; i++) {
        NSMenuItem *item = [menu itemAtIndex:i];
        if (![item isSeparatorItem]) {
            // In IB, the tag was set to the appropriate rowSizeStyle. Read in that value.
            NSInteger state = ([item tag] == [_sidebarOutlineView rowSizeStyle]) ? 1 : 0;
            [item setState:state];
        }
    }
}

- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview {
    return NO;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex {
    if (proposedMinimumPosition < 75) {
        proposedMinimumPosition = 75;
    }
    return proposedMinimumPosition;
}


@end
