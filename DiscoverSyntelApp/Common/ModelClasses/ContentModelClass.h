//
//  ContentModelClass.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModelClass : NSObject
{
    NSMutableArray *_itemNewsModel;
    NSMutableArray *_itemVideosModel;
    NSMutableArray *_itemCaseStudiesModel;
    NSMutableArray *_itemWhitePapersModel;
    NSMutableArray* _itemWhatsNewModel;
    NSMutableArray* _dateTag;
    NSString* _dateTagString;
    NSMutableArray *_finalContentArray;

}

@property (nonatomic, retain) NSMutableArray *itemNewsModel;
@property (nonatomic, retain) NSMutableArray *itemVideosModel;
@property (nonatomic, retain) NSMutableArray *itemCaseStudiesModel;
@property (nonatomic, retain) NSMutableArray *itemWhitePapersModel;
@property (nonatomic, retain) NSMutableArray *itemWhatsNewModel;
@property (nonatomic, retain) NSMutableArray *finalContentArray;
@property (nonatomic, retain) NSMutableArray *dateTag;
@property (nonatomic, retain) NSString* dateTagString;
@end
