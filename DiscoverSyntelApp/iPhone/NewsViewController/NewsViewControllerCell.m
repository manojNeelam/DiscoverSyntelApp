//
//  NewsViewControllerCell.m
//  DiscoverSyntelApp
//
//  Created by reema on 17/05/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "NewsViewControllerCell.h"

@implementation NewsViewControllerCell
@synthesize otlLblDescription,otlLblPubDate,otlLblTitle;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
