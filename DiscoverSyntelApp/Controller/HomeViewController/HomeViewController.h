//
//  HomeViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/14/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WebViewController.h"
#import "WebViewDisplayLinks.h"
#import "IndustrialOfferingsViewController.h"
#import "TechnologyOfferingsViewController.h"
#import "ThoughtLeaderShipViewController.h"
#import "WhatsNewViewController.h"
#import "NewsListViewController.h"
#import "ContactUsiPadViewController.h"
#import "IndustrySolutionsViewController.h"
#import "TechnologyServicesViewController.h"


@interface HomeViewController : BaseViewController
{
    IBOutlet UIButton *otlBtnTechnologyOfferings;
    IBOutlet UIButton *otlBtnIndustryOfferings;
    BOOL isMenuSelected;
    WebViewController *objWebViewController;
    WebViewDisplayLinks *objWebViewDisplayLinks;
    
    //IndustrialOfferingsViewController *objIndustrialOfferingsViewController;
    //TechnologyOfferingsViewController *objTechnologyOfferingsViewController;
    
    IndustrySolutionsViewController *objIndustrialOfferingsViewController;
    TechnologyServicesViewController *objTechnologyOfferingsViewController;
    
    ThoughtLeaderShipViewController *objThoughtLeaderShipViewController;
    WhatsNewViewController *objWhatsNewViewController;
    NewsListViewController *objNewsListViewController;
    ContactUsiPadViewController* contactUsiPadViewController;
}

//Changes by Amar on may 8 th 2015

@property (nonatomic ,weak) IBOutlet UIImageView *banner_iPad;

-(IBAction)onClickIndustryOfferings:(id)sender;
-(IBAction)onClickTechnologyOfferings:(id)sender;
-(IBAction)onClickMenuButton:(UIButton*)sender;
@end
