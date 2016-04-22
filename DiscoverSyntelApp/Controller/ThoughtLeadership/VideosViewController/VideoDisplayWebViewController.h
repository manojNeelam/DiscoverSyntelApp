//
//  VideoDisplayWebViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VideoDisplayWebViewController : BaseViewController
{
    IBOutlet UIWebView *otlWebViewVideo;
    IBOutlet UIButton *otlBtnFavourites;
    BOOL isVideoFormatSupported;
    BOOL isVideoLoaded;
}
@property(nonatomic,strong)NSMutableDictionary *dicOfContentLoaded;
@property(nonatomic,strong)NSString *strUrlIndustryOfferings;
@property(nonatomic,strong)NSString *strVideoType;
@property(nonatomic,strong)UIImage *imageAddToFavourite;
@property(nonatomic,strong)UIImage *imageRemoveFromFavourite;

-(IBAction)onClickBack:(id)sender;
-(IBAction)onClickForward:(id)sender;
-(IBAction)onClickShare:(id)sender;
-(IBAction)onClickFavourite:(id)sender;

@end
