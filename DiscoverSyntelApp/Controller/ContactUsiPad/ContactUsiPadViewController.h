//
//  ContactUsiPadViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 6/2/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactUsmapiPadViewController.h"
#import "WebViewController.h"
#import "BaseViewController.h"

@interface ContactUsiPadViewController : BaseViewController
{
    IBOutlet UIView* mapViewNContactView;
    IBOutlet UISegmentedControl* segmentControl;

}
@property(nonatomic,retain) ContactUsmapiPadViewController* contactUsmapiPadViewController;
@property(nonatomic,retain) WebViewController* contactUsWebViewController;
-(IBAction)segmentControlSelectionContactUs:(id)sender;

@end
