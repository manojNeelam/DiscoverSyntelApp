//
//  NewsModelClass.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "NewsModelClass.h"

@implementation NewsModelClass
@synthesize title=_title, description=_description, publishDate=_publishDate, locationPath=_locationPath, source=_source;

-(id)initWithName:(NSString *)title description:(NSString*)description publishingDate:(NSString*)publishDate locationPath:(NSString*)locationPath sourcePath:(NSString*)source tinyURL:(NSString*)tinyURL
{
    
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.publishDate = publishDate;
        self.locationPath = locationPath;
        self.source = source;
        self.tinyURL=_tinyURL;
    }

    return self;

}

@end
