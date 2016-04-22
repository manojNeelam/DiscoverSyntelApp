//
//  ThoughtLeadershipControllerIphone.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/21/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideosGridViewControlleriPhone.h"
#import "WhitePapersNCaseStudiesIphoneViewController.h"
#import "DownloadViewControlleriPhoneViewController.h"
#import "BaseViewControllerIphone.h"

@interface ThoughtLeadershipControllerIphone : BaseViewControllerIphone
{
    IBOutlet UISegmentedControl *otlSegmentThoughtLeadershipIphone;
    IBOutlet UIView *otlViewThoughtLeadershipIphone;
    VideosGridViewControlleriPhone *objVideosViewController;
    NSString *strSelected;
    WhitePapersNCaseStudiesIphoneViewController* objWhitePapersNCaseStudiesIphoneViewController;

}
@property(nonatomic,retain)  WhitePapersNCaseStudiesIphoneViewController* objWhitePapersNCaseStudiesIphoneViewController;
@property(nonatomic,retain)  DownloadViewControlleriPhoneViewController* objDownloadViewControlleriPhoneViewController;
-(void)loadDefaultView;
@end
