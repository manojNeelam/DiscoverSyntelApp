//
//  ConatctContentCell.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import "ConatctContentCell.h"

@implementation ConatctContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)populateData:(SyntelAddressData *)aData
{
    [self cleanCell];
    
    [self.lblTitle setText:aData.title];
    
    if(aData.contact && aData.contact != nil && ![aData.contact isEqualToString:@""])
    {
        
        [self.lblContactNUmber setHidden:NO];
        [self.lblTel setHidden:NO];
        
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:aData.contact];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        
        
        [self.lblContactNUmber setAttributedText:attributeString];
    }
    else
    {
        [self.lblContactNUmber setHidden:YES];
        [self.lblTel setHidden:YES];
    }
    
    [self.lblCompany setText:aData.companyName];
    [self.lblAddress setText:aData.street];
}

-(void)cleanCell
{
    [self.lblTitle setText:@""];
    [self.lblContactNUmber setText:@""];
    [self.lblCompany setText:@""];
    [self.lblAddress setText:@""];
}

@end
