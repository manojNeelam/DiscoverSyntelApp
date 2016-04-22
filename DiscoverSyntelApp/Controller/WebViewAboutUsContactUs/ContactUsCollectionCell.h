//
//  ContactUsCollectionCell.h
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyntelAddressData.h"

@interface ContactUsCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UILabel *lblStreet;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblContact;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintStreetHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAddressHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTitleHeight;

-(void)populateData:(SyntelAddressData *)syntelAddressData;


@end
