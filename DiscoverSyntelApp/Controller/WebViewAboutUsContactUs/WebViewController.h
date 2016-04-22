//
//  WebViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/18/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewController : BaseViewController
{
    IBOutlet UIWebView *otlWebView;
}
@property (weak, nonatomic) IBOutlet UICollectionView *addressCollectionView;
@property(nonatomic,strong)NSString *strWebViewTitle;
@end
