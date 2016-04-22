//
//  WebViewDisplayData.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebViewDisplayData : NSObject
{
    NSString *strURLDisplay;
    NSString *strTinyURLDisplay;
    NSString *strTitleDisplay;
    NSString *strDescriptionDisplay;
    NSString *strPubDateDisplay;
    NSString *strPageTitle;
    NSString *strSourceURL;
    NSString *strFilePath;
    
    
}
@property(nonatomic,strong)NSString *strURLDisplay;
@property(nonatomic,strong)NSString *strTinyURLDisplay;
@property(nonatomic,strong)NSString *strTitleDisplay;
@property(nonatomic,strong)NSString *strDescriptionDisplay;
@property(nonatomic,strong)NSString *strPubDateDisplay;
@property(nonatomic,strong)NSString *strPageTitle;
@property(nonatomic,strong)NSString *strSourceURL;
@property(nonatomic,strong)NSString *strFilePath;



@end
