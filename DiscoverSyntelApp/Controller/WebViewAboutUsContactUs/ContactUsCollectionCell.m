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
    
    if(syntelAddressData.contact && syntelAddressData.contact != nil && ![syntelAddressData.contact isEqualToString:@""])
    {
        [self.lblTel setHidden:NO];
        [self.lblContact setHidden:NO];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:syntelAddressData.contact];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        
        
        [self.lblContact setAttributedText:attributeString];
    }
    else
    {
        [self.lblTel setHidden:YES];
        [self.lblContact setHidden:YES];
    }
}

-(void)clearCell
{
    [self.lblTitle setText:@""];
    [self.lblCompanyName setText:@""];
    [self.lblStreet setText:@""];
    [self.lblContact setText:@""];
}

@end
