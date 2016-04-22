//
//  ContactUsCollectionCell.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import "ContactUsCollectionCell.h"

@implementation ContactUsCollectionCell

-(void)populateData:(SyntelAddressData *)syntelAddressData
{
    [self clearCell];
    
    [self.lblTitle setText:syntelAddressData.title];
    [self.lblCompanyName setText:syntelAddressData.companyName];
    [self.lblStreet setText:syntelAddressData.street];
    [self.lblAddress setText:syntelAddressData.address];
    [self.lblContact setText:syntelAddressData.contact];
}

-(void)clearCell
{
    [self.lblTitle setText:@""];
    [self.lblCompanyName setText:@""];
    [self.lblStreet setText:@""];
    [self.lblAddress setText:@""];
    [self.lblContact setText:@""];
}

@end
