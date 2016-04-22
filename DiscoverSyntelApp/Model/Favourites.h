//
//  Favourites.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/3/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Favourites : NSManagedObject

@property (nonatomic, retain) NSString * favouriteFilePath;
@property (nonatomic, retain) NSString * favouriteID;
@property (nonatomic, retain) NSString * favouriteLink;
@property (nonatomic, retain) NSString * favouritePubDate;
@property (nonatomic, retain) NSString * favouriteTitle;
@property (nonatomic, retain) NSString * favouriteType;
@property (nonatomic, retain) NSString * favouriteTinyUrl;

@end
