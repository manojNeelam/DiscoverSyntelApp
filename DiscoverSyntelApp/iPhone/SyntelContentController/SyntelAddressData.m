//
//  SyntelAddressData.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import "SyntelAddressData.h"

@implementation SyntelAddressData
@synthesize title, address, contact, companyName, street;

-(id)initwithDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];
    return self;
}


-(void)parseDictionary:(NSDictionary *)dict
{
    self.title = [dict objectForKey:@"title"];
    self.companyName = [dict objectForKey:@"companyName"];
    self.address = [dict objectForKey:@"address"];
    self.contact = [dict objectForKey:@"tel"];
    self.street = [dict objectForKey:@"street"];
    
}
@end
