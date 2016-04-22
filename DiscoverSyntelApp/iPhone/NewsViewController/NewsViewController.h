//
//  NewsViewController.h
//  DiscoverSyntelApp
//
//  Created by reema on 17/05/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewControllerCell.h"
#import "BaseViewControllerIphone.h"

@interface NewsViewController : BaseViewControllerIphone
{
    NewsViewControllerCell *objNewsViewControllerCell;
    NSMutableArray *arrNewsDataSource;
    IBOutlet UITableView *otlTableViewNews;
}
@end
