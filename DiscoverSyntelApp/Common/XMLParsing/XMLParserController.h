//
//  XMLParserController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParserController : NSObject<NSXMLParserDelegate>
{
    NSData* data;
    NSXMLParser* xmlParser;
    NSMutableDictionary* parentDict;
    NSMutableArray* parentDictArray;
    NSMutableDictionary* itemDict;
    NSMutableArray* itemDictArray;
    
    NSString* parentString;
    int parserDelegateTrackCount;
    
}

-(void)parseXML;
-(void)checkNewXML:(NSString*)dateString;
-(void)changeSet:(NSMutableArray*)changeSetArray;


@property(nonatomic, retain) NSString* elementString;
@end
