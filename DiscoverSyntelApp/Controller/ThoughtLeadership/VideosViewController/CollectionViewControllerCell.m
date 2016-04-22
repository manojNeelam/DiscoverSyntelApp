//
//  CollectionViewControllerCell.m
//  ResourceManagement
//
//  Created by Sanjay on 9/16/13.
//  Copyright (c) 2013 Syntel MacBook 002. All rights reserved.
//

#import "CollectionViewControllerCell.h"

@implementation CollectionViewControllerCell
@synthesize titleLabel, pubDateLabel, imageView,btnDownloadVideo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
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
-(IBAction)onClickDownloadVideo:(UIButton*)sender
{
    NSMutableDictionary *dicTagVal=[[NSMutableDictionary alloc]init];
    [dicTagVal setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"btnTag"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationOnClickDownloadVideo" object:nil userInfo:dicTagVal];
   
    

}

@end
