//
//  WhatsNewViewControllerIphone.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerIphone.h"
#import "WhatsNewControllerCell.h"
#import "BaseViewControllerIphone.h"

@interface WhatsNewViewControllerIphone : BaseViewControllerIphone
{
    WhatsNewControllerCell *objWhatsNewControllerCell;
    NSMutableArray *arrWhatsNewDataSource;
    IBOutlet UITableView *otlTableViewWhatsNew;
    IBOutlet UILabel *otlLblContentNotAvailable;

}
@end
