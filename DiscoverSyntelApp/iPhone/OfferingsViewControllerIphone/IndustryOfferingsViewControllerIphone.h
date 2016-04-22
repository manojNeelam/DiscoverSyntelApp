//
//  IndustryOfferingsViewControllerIphone.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewDisplayData.h"
#import "BaseViewControllerIphone.h"
#import "MPFlipViewController.h"


@interface IndustryOfferingsViewControllerIphone : BaseViewControllerIphone
{
    NSArray *arrIndustrialOfferingsMenu;
    IBOutlet UIView* flipView;
    
}
@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (nonatomic,retain)IBOutlet UIView* flipView;
@end
