//
//  ListItemTableViewController.h
//  PerformINS
//
//  Created by Aniket Bidwai on 31/03/14.
//  Copyright (c) 2014 syntel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItemProtocol.h"
#import "NewsListCellController.h"
#import "WhatsNewCellController.h"

@interface ListItemTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listArray;
    id<ListItemProtocol> delegate;
    UIButton *selectedButton;
    WhatsNewCellController *objWhatsNewCellController;
     NewsListCellController *objNewsListCellController;
    NSString *strIdentifier;
    NSMutableDictionary *dicContent;
    NSArray *arrThoughtLeadership;
}
@property(nonatomic,retain) NSMutableArray *listArray;
@property(nonatomic,strong) id<ListItemProtocol> delegate;
@property(nonatomic,readwrite) UIButton *selectedButton;

- (id)initWithStyle:(UITableViewStyle)style andListArray:(NSMutableArray*) array andButton:(UIButton*) button andIdentifier:(NSString*)identifier;



@end
