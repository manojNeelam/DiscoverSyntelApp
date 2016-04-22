//
//  ConatctContentCell.h
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyntelAddressData.h"

@interface ConatctContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCompany;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblContactNUmber;
@property (weak, nonatomic) IBOutlet UILabel *lblTel;
@property (weak, nonatomic) IBOutlet UILabel *lblStreet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrStreetHeight;

-(void)populateData:(SyntelAddressData *)aData;

@end
