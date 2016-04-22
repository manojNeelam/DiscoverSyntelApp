//
//  ModalListViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewDisplayData.h"

@interface ModalListViewController : UIViewController
{
    IBOutlet UINavigationBar *otlNavBar;
    WebViewDisplayData *objWebViewDisplayData;
    IBOutlet UITableView *objFavouriteTable;
    BOOL isModalViewControllerLoaded;
}
@property(nonatomic,strong)NSMutableArray *arrOfValues;
@property(nonatomic,strong)NSMutableDictionary *dicMarkedFavourites;
@property(nonatomic,strong)NSString *arrOfImages;
@property(nonatomic,retain)IBOutlet UITableView *objFavouriteTable;
-(IBAction)onClickCancel:(UIBarButtonItem*)sender;
@end
