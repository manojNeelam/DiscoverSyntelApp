//
//  HomeViewControllerIphone.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/14/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPFlipViewController.h"
#import "HomeContentViewController.h"
#import "ContentViewController.h"
#import "BaseViewControllerIphone.h"
@interface HomeViewControllerIphone : BaseViewControllerIphone<MPFlipViewControllerDelegate, MPFlipViewControllerDataSource>
{
    IBOutlet UIView* flipView;
     
    
}

@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (nonatomic,retain)IBOutlet UIView* flipView;
@end
