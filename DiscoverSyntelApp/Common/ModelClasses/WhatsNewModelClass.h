//
//  WhatsNewModelClass.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhatsNewModelClass : NSObject
{
    NSString *_title;
    NSString *_description;
    NSString *_publishDate;
    NSString *_locationPath;
    NSString *_category;
    NSString *_source;
   
}


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *publishDate;
@property (nonatomic, copy) NSString *locationPath;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *source;

-(id)initWithName:(NSString *)title description:(NSString*)description publishingDate:(NSString*)publishDate locationPath:(NSString*)locationPath category:(NSString*)category sourcePath:(NSString*)source;


@end
