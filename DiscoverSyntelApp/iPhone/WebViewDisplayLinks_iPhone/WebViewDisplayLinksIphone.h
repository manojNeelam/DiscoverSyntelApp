//
//  WebViewDisplayLinksIphone.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewDisplayData.h"
#import "BaseViewControllerIphone.h"
#import "FavouritesController.h"


@interface WebViewDisplayLinksIphone : BaseViewControllerIphone
{
    IBOutlet UIWebView *otlWebViewDisplayData;
    IBOutlet UIButton *otlBtnBack;
    IBOutlet UIButton *otlBtnFavourites;
    FavouritesController *objFavouritesController;
    UIImage *imageAddToFavourite;
    UIImage *imageRemoveFromFavourite;
}
@property(nonatomic,strong)WebViewDisplayData *webViewDisplayDataReceived;
-(IBAction)onClickBackBtn:(id)sender;
-(IBAction)onClickFavourites:(UIButton*)sender;
-(IBAction)onClickShare:(UIButton*)sender;
@end
