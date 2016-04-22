//
//  TechnologyOfferingsViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerIphone.h"
#import "MPFlipViewController.h"

@interface TechnologyOfferingsViewControllerIphone : BaseViewControllerIphone
{
    NSArray *arrTechnicalOfferingsMenu;
    IBOutlet UIView* flipView;

}
@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (nonatomic,retain)IBOutlet UIView* flipView;



@end
