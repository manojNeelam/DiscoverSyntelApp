//
//  WebViewDisplayLinks.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/26/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewDisplayLinks :BaseViewController
{
    IBOutlet UIWebView *otlWebViewIndustryOfferings;
    IBOutlet UIButton *otlBtnBack;
    IBOutlet UIButton *otlBtnForward;
    IBOutlet UIButton *otlBtnFavourites;
    int countReload;
    NSString *strIdentifierWebContent;
    
    
}
@property(nonatomic,strong)NSString *strUrlWebViewDisplay;
@property(nonatomic,strong)NSString *strUrlIndustryOfferings;
@property(nonatomic,strong)NSString *strWebViewTitle;
@property(nonatomic,strong)UIImage *imageAddToFavourite;
@property(nonatomic,strong)UIImage *imageRemoveFromFavourite;
@property(nonatomic,strong)NSMutableDictionary *dicOfContentLoaded;// dic includes file path, url, pubdate and title
-(IBAction)onClickBack:(id)sender;
-(IBAction)onClickForward:(id)sender;
-(IBAction)onClickShare:(id)sender;
-(IBAction)onClickFavourite:(id)sender;
@end

