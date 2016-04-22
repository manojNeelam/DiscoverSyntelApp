//
//  VideosModelClass.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideosModelClass : NSObject
{
    NSString *_title;
    NSString *_description;
    NSString *_publishDate;
    NSString *_locationPath;
    NSString *_source;
    NSString *_image;
    NSString* _tinyURL;
}
@property (nonatomic, copy) NSString *tinyURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *publishDate;
@property (nonatomic, copy) NSString *locationPath;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *image;

-(id)initWithName:(NSString *)title description:(NSString*)description publishingDate:(NSString*)publishDate locationPath:(NSString*)locationPath image:(NSString*)image sourcePath:(NSString*)source tinyURL:(NSString*)tinyURL;


@end
