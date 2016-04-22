//
//  XMLParserGData.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ContentModelClass;

@interface XMLParserGData : NSObject
{
    
}


+ (ContentModelClass *)loadContent:(NSString*)xmlType;
+ (void)saveContent:(ContentModelClass *)content :(ContentModelClass*)secondXMLContent;
//-(void)changeSet:(NSMutableArray*)changeSetArray;
@end
