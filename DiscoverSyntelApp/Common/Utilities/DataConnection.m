//
//  DataConnection.m
//  ResourceManagement
//
//  Created by Mudit on 26/08/13.
//  Copyright (c) 2013 Syntel MacBook 002. All rights reserved.
//

#import "DataConnection.h"
#import "Reachability.h"

@implementation DataConnection

-(BOOL)networkConnection
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
  //  Reachability *reachabilityForWiFi=[Reachability reachabilityForLocalWiFi];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
   // NetworkStatus networkStatusForWifi = [reachabilityForWiFi currentReachabilityStatus];
    
    
    if (networkStatus == NotReachable)
    {
        UIAlertView* noConnectionAlert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"There is no active network available. Check Wi-Fi and Network Settings." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [noConnectionAlert show];
        return NO;
    }

    return YES;
}



@end
