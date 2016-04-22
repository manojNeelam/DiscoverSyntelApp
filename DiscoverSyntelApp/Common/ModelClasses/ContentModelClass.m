//
//  ContentModelClass.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ContentModelClass.h"

@implementation ContentModelClass
@synthesize itemNewsModel=_itemNewsModel,itemVideosModel=_itemVideosModel,itemCaseStudiesModel=_itemCaseStudiesModel,itemWhitePapersModel=_itemWhitePapersModel,itemWhatsNewModel=_itemWhatsNewModel, finalContentArray=_finalContentArray,dateTag=_dateTag,dateTagString=_dateTagString;

- (id)init {
    
    if ((self = [super init])) {
        self.itemNewsModel = [[NSMutableArray alloc] init];
        self.itemVideosModel=[[NSMutableArray alloc] init];
        self.itemWhatsNewModel =[[NSMutableArray alloc] init];
        self.itemWhitePapersModel=[[NSMutableArray alloc] init];
        self.itemCaseStudiesModel=[[NSMutableArray alloc] init];
        self.finalContentArray= [[NSMutableArray alloc]init];
        self.dateTag = [[NSMutableArray alloc]init];
        self.dateTagString= [[NSString alloc]init];
    }
    return self;
}
@end
