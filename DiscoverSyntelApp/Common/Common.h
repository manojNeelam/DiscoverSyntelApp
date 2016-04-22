//
//  Common.h
//  ThoughtLeaderShip
//
//  Created by Mobile Computing on 3/20/14.
//  Copyright (c) 2013 Syntel MacBook 002. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate_iPhone.h"

#ifndef Common_h
#define Common_h


//AppDelegate SharedInstance
#define APP_INSTANCE  (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define APP_INSTANCE_IPHONE  (AppDelegate_iPhone*)[[UIApplication sharedApplication] delegate]
//Defining Favourites Options
#define News @"News"
#define Videos @"Videos"
#define WhitePapers @"White Papers"
#define CaseStudies @"Case Studies"
#define TechnicalOfferings @"Technology Offerings"
#define IndustrialOfferings @"Industrial Offerings"
#define NewsFavourites @"NewsFavourites"
#define VideosFavourites @"VideosFavourites"
#define WhitePapersFavourites @"WhitePapersFavourites"
#define CaseStudiesFavourites @"CaseStudiesFavourites"
#define TechnicalOfferingsFavourites @"TechnologyOfferingsFavourites"
#define IndustrialOfferingsFavourites @"industrialOfferingFavourites"

//Defining Favourites Table Keys
#define favFilePathKey @"favouriteFilePath"
#define favIdKey @"favouriteID"
#define favLinkKey @"favouriteLink"
#define favouritePubDateKey @"favouritePubDate"
#define favouriteTitleKey @"favouriteTitle"
#define favouriteTypeKey @"favouriteType"



//Defining Content Cell Data Keys
#define strTitle @"title"
#define pubDate @"pubDate"

//Defining Parsed XML keys
#define ParsedNews @"parsedNews"

//Defining Folder Name Keys
#define IndustryOfferingsFolder @"IndustryOfferings"
#define NewsFolder @"News"
#define TechnologyOfferingsFolder @"TechnologyOfferings"
#define FavoritesFolder @"Favorites"
#define ThoughtLeadershipFolder @"ThoughtLeadership"
#define WhatsNewFolder @"WhatsNew"

#define DownloadedVideo @"DownloadedVideo"
#define OnlineVideo @"OnlineVideo"

//URLs


#define dmzCheckNewContent @"https://marcom.syntel.in/Notification/api/DeviceTokens"

#define dmzDownloadNewXML @"https://marcom.syntel.in/Notification/DeviceContent/WebContent.xml";

//#define dmzDownloadNewXML @"https://marcom.syntel.in/Notificx ation/DeviceContent/WebContent.xml";

//#define dmzDownloadNewXML @"https://marcom.syntel.in/Notification/DeviceContent/WebContent_withBannerImg.xml";

#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE5          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE6          (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE6PLUS      (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_RETINA           ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
#endif

#define IPHONE4_URL @"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone.png"
#define IPHONE5_URL @"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone_2X.png"
#define IPHONE6URL  @"hhttps://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone_2X.png"
#define IPADURL     @"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad.png"
#define IPADRETINA  @"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad_2X.png"

#define DEFAULT_IPHONE_BANNERIMAGE  @"BannerIphone.png"
