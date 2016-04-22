//
//  WhitePapersModelClass.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhitePapersModelClass.h"

@implementation WhitePapersModelClass
@synthesize title=_title, description=_description, publishDate=_publishDate, locationPath=_locationPath, source=_source, image=_image, category=_category,tinyURL=_tinyURL;

-(id)initWithName:(NSString *)title category:(NSString*)category description:(NSString*)description publishingDate:(NSString*)publishDate locationPath:(NSString*)locationPath image:(NSString*)image sourcePath:(NSString*)source tinyURL:(NSString*)tinyURL
{
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.publishDate = publishDate;
        self.locationPath = locationPath;
        self.image=image;
        self.source = source;
        self.image=image;
        self.tinyURL=tinyURL;
    }
    
    return self;
}

@end
