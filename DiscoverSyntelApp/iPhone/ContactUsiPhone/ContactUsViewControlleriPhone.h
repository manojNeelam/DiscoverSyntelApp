//
//  ContactUsViewControlleriPhone.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactUsMapViewController.h"
#import "SyntelContentController.h"


@interface ContactUsViewControlleriPhone : BaseViewControllerIphone
{
    IBOutlet UIView* mapViewNContactView;
    IBOutlet UISegmentedControl* segmentControl;
    ContactUsMapViewController* contactUsMapViewController;
    SyntelContentController* syntelContentController;
    
}
@property(nonatomic,retain) ContactUsMapViewController* contactUsMapViewController;
@property(nonatomic,retain) SyntelContentController* syntelContentController;
-(IBAction)segmentControlSelectionContactUs:(id)sender;

@end
