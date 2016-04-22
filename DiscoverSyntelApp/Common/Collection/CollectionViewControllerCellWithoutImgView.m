//
//  CollectionViewControllerCellWithoutImgView.m
//  ThoughtLeadership
//
//  Created by Mobile Computing on 3/30/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "CollectionViewControllerCellWithoutImgView.h"

@implementation CollectionViewControllerCellWithoutImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionViewControllerCellWithoutImgView" owner:self options:nil];
        
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
