//
//  WhatsNewCellController.m
//  DiscoverSyntelApp
//
//  Created by reema on 22/04/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhatsNewCellController.h"

@interface WhatsNewCellController ()

@end

@implementation WhatsNewCellController
@synthesize otlLblDescription,otlLblPubDate,otlLblTitle,otlImageWhatsNew;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
