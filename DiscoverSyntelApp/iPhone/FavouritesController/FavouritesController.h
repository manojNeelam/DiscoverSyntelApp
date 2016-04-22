//
//  FavouritesController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/16/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewDisplayData.h"

@interface FavouritesController : NSObject
-(void)saveFavouritesForURL:(WebViewDisplayData*)obj;
-(BOOL)deleteFavouritesForURL:(NSString*)strURL sourceURL:(NSString*)strSourceURL;
-(BOOL)fetchFavouritesOnLoadForURL:(NSString*)strURL sourceURL:(NSString*)strSourceURL;

@end
