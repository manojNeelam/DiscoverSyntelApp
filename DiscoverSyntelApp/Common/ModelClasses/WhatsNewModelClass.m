//
//  WhatsNewModelClass.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhatsNewModelClass.h"

@implementation WhatsNewModelClass
@synthesize title=_title, description=_description, publishDate=_publishDate, locationPath=_locationPath,category=_category;

-(id)initWithName:(NSString *)title description:(NSString*)description publishingDate:(NSString*)publishDate locationPath:(NSString*)locationPath category:(NSString*)category sourcePath:(NSString*)source
{
    
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.publishDate = publishDate;
        self.locationPath = locationPath;
        self.category=category;
        self.source=source;
       
    }
    
    return self;
    
}


@end
