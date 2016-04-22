//
//  WhitePapersModelClass.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhitePapersModelClass : NSObject
{
    NSString *_title;
    NSString *_category;
    NSString *_description;
    NSString *_publishDate;
    NSString *_locationPath;
    NSString *_image;
    NSString *_source;
    NSString* _tinyURL;
}
@property (nonatomic, copy) NSString *tinyURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *publishDate;
@property (nonatomic, copy) NSString *locationPath;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *source;

-(id)initWithName:(NSString *)title category:(NSString*)category description:(NSString*)description publishingDate:(NSString*)publishDate locationPath:(NSString*)locationPath image:(NSString*)image sourcePath:(NSString*)source tinyURL:(NSString*)tinyURL;


@end
