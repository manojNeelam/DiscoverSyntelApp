//
//  CollectionViewControllerCell.m
//  ResourceManagement
//
//  Created by Sanjay on 9/16/13.
//  Copyright (c) 2013 Syntel MacBook 002. All rights reserved.
//

#import "CollectionViewControllerCell.h"

@implementation CollectionViewControllerCell
@synthesize titleLabel, pubDateLabel, imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
// Initialization code
//        NSArray *contentViewNib = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewControllerCell" owner:self options:nil];
//        [self.contentView addSubview:contentViewNib[0]];
//        
        
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewControllerCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];

        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
