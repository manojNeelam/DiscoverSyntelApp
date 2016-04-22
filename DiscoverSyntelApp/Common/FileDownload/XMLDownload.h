//
//  XMLDownload.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/17/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModelClass.h"
@interface XMLDownload : NSObject
{
    NSString* sourcePathStr;
    NSString* targetPathStr;
   
}
@property (nonatomic, retain) ContentModelClass *contentModel;
@property (nonatomic, retain) ContentModelClass *contentModelSecondXML;
-(void)downloadXML:(NSDictionary*)urlDict;
@end
