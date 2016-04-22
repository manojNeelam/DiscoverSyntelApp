//
//  ActivitySharingViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 6/3/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ActivitySharingViewController.h"

@interface TextItemProvider:UIActivityItemProvider
@property (nonatomic, strong) NSArray *arrActivities;
@end



@implementation TextItemProvider
@synthesize arrActivities;

- (id)initWithPlaceholderItem:(id)placeholderItem
{
    //Initializes and returns a provider object with the specified placeholder data
    
    return [super initWithPlaceholderItem:placeholderItem];
}

- (id)item
{
    //Generates and returns the actual data object
    return @"";
}

// The following are two methods in the UIActivityItemSource Protocol
// (UIActivityItemProvider conforms to this protocol) - both methods required

//- Returns the data object to be acted upon. (required)
- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    
   return [activityViewController initWithActivityItems:arrActivities applicationActivities:nil];
    
   // return activityViewController;
}

//- Returns the placeholder object for the data. (required)
//- The class of this object must match the class of the object you return from the above method
- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return @"";
}
#pragma mark - UIInterfaceOrientation
-(BOOL)shouldAutorotate
{
    return YES;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


@end
