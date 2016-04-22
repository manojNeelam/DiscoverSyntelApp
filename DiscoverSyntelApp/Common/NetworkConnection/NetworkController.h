//
//  NetworkController.h
//  ThoughtLeaderShip
//
//  Created by Arshad Ahmad Khan on 3/8/14.
//  Copyright (c) 2014 Syntel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFXMLRequestOperation.h"

@interface NetworkController : AFHTTPClient<NSXMLParserDelegate>
{
    NSMutableArray* titleArray;
    NSMutableArray* linkArray;
    NSMutableArray* pubDateArray;
    NSString* parentString;
    NSMutableDictionary* rowDict;
    NSMutableArray* newsRowArray;
}

+(id)sharedManager;

-(void)getNewsAndVideos:(NSString*)urlReceived;

@property(strong)NSMutableDictionary* xmlNews;

@property(nonatomic, retain) NSString* elementString;




@end
