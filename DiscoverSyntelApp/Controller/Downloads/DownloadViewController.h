//
//  DownloadViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/18/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewDisplayLinks.h"
#import "DownloadCellController.h"

@interface DownloadViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *arrDataSourceDownload;
    NSArray *directoryContentsCaseStudies;
    NSArray *directoryContentsWhitePapers;
    NSArray *directoryContentsVideos;
    DownloadCellController *objDownloadCellController;
    NSString *directoryHtmlCaseStudies;
    NSString *directoryHtmlWhitePapers;
    NSString *directoryHtmlVideos;
    NSString* urlLinkString;
    IBOutlet UITableView* objTableView;
  //  UIButton *objBtnDeleteDownload;
    WebViewDisplayLinks *objWebViewDisplayLinks;
    NSArray *arrDownloadIcon;
    NSArray *arrDownloadIconRetina;
    NSString *strFilePath;// File name to be deleted
    
    
}
@end
