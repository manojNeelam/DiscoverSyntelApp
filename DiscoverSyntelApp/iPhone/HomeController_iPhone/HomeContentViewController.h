//
//  HomeContentViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeContentViewController : UIViewController
{
    IBOutlet UILabel *otlLblFlip;
    BOOL isMenuSelected;
}

@property (assign, nonatomic) NSUInteger mo;
@property (nonatomic,strong)IBOutlet UILabel *otlLblFlip;



// code added by aamar on 8 th may 2015

@property (nonatomic, weak) IBOutlet UIImageView *bannerImage;



-(IBAction)onClickHomeMenuOptions:(UIButton*)sender;
@end
