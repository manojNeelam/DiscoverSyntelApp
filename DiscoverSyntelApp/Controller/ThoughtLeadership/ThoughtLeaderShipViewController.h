//
//  ThoughtLeaderShipViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideosGridViewController.h"
#import "WhitePapersCaseStudiesListViewController.h"
#import "BaseViewController.h"
#import "DownloadViewController.h"


@interface ThoughtLeaderShipViewController : BaseViewController
{
    IBOutlet UIView *otlViewThoughtLeadership;
    IBOutlet UISegmentedControl *otlSegmentThoughtLeadership;
    VideosGridViewController *objVideosGridViewController;
    WhitePapersCaseStudiesListViewController *objWhitePapersCaseStudiesListViewController;
    NSString *strSelected;
}
@property(nonatomic,retain)WhitePapersCaseStudiesListViewController *objWhitePapersCaseStudiesListViewController;
@property(nonatomic,retain)DownloadViewController *objDownloadViewController;
-(IBAction)segmentControlSelection:(id)sender;
@end
