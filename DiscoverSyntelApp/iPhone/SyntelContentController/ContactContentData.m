//
//  ContactContentData.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import "ContactContentData.h"
#import "SyntelAddressData.h"

@implementation ContactContentData
@synthesize countryTitle, addressList, isOpen;

-(id)initwithDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];
    return self;
}


-(void)parseDictionary:(NSDictionary *)dict
{
    self.countryTitle = [dict objectForKey:@"country_Name"];
    NSArray *tempAddress = [dict objectForKey:@"address"];
    if(tempAddress.count)
    {
        NSMutableArray *holder = [[NSMutableArray alloc] init];
        for(NSDictionary *dictAdd in tempAddress)
        {
            SyntelAddressData *syntelAddressData = [[SyntelAddressData alloc] initwithDictionary:dictAdd];
            [holder addObject:syntelAddressData];
        }
        
        self.addressList = holder;
    }
}

@end
