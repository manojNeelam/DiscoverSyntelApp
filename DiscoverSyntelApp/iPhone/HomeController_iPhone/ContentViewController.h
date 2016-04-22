//
//  ContentViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
{
    IBOutlet UIButton* button1;
    IBOutlet UIButton* button2;
    IBOutlet UIButton* button3;
    IBOutlet UIButton* button4;
    IBOutlet UILabel *otlLblPage;
    IBOutlet UILabel *otlLblFlip;
    BOOL isFlipLabelHidden;
    BOOL isMenuSelected;

    
}

@property (assign, nonatomic) NSUInteger pageIndex;
@property (nonatomic, retain) NSString* pageIdentifier;
@property (nonatomic,retain)IBOutlet UILabel *otlLblFlip;
@property (nonatomic, retain) UILabel *otlLblPage;
-(IBAction)onClickBtnOption:(id)sender;

@end
