//
//  DownloadViewControlleriPhoneViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadViewCelliPhone.h"

@interface DownloadViewControlleriPhoneViewController : UIViewController
{
    NSArray *arrDataSourceDownload;
    NSArray *directoryContentsCaseStudies;
    NSArray *directoryContentsWhitePapers;
    NSArray *directoryContentsVideos;
    DownloadViewCelliPhone* objDownloadCellController;
    NSString *directoryHtmlCaseStudies;
    NSString *directoryHtmlWhitePapers;
    NSString *directoryHtmlVideos;
    NSString* urlLinkString;
    IBOutlet UITableView* objTableView;
    NSArray *arrDownloadIcon;
    NSArray *arrDownloadIconRetina;
    NSString *strFilePath;// File name to be deleted
}
@end
