//
//  WhatsNewViewController.h
//  DiscoverSyntelApp
//
//  Created by reema on 22/04/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhatsNewCellController.h"
#import "BaseViewController.h"
#import "ListItemTableViewController.h"

@interface WhatsNewViewController : BaseViewController<ListItemProtocol>
{
    IBOutlet UITableView *otlTableWhatsNewList;
    WhatsNewCellController* objWhatsNewCellController;
    NSArray *arrDataSourceParsedDataWhatsNew;
    NSMutableArray *arrDataSourceWhatsNewList;
    NSString* linkStringToPass;
    NSString *strTitleToPass;
    NSMutableDictionary *dicContentReceived;
    IBOutlet UILabel *otlLblContentNotAvailable;
}
@end
