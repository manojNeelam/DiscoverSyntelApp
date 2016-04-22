//
//  NewsListViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/10/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NewsListCellController.h"
#import "ListItemProtocol.h"

@interface NewsListViewController :BaseViewController<ListItemProtocol>
{
   // IBOutlet UITableView *otlTableNewsList;
    NSMutableArray *arrOfFiles;
    NewsListCellController *objNewsListCellController;
    NSArray *arrDataSourceParsedDataNews;
    NSMutableArray *arrDataSourceNewsList;
    NSString* linkStringToPass;
    NSString* strTitleToPass;
    NSString *strTinyUrl;


}
@property(nonatomic,strong)NSString *strIdentifierFolder;
@property(weak,nonatomic)IBOutlet UITableView *_otlTableNewsList;
@end
