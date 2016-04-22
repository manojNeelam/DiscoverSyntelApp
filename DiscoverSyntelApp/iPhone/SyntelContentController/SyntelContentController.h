//
//  SyntelContentController.h
//  DiscoverSyntelApp
//
//  Created by reema on 17/05/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerIphone.h"

@interface SyntelContentController : BaseViewControllerIphone
{
    IBOutlet UIWebView *otlWebViewSyntelContent;
    IBOutlet UIButton *otlBtnGoBack;
}
@property(nonatomic,strong)NSString *strWebViewTitle;
-(IBAction)goToBack:(id)sender;
@end
