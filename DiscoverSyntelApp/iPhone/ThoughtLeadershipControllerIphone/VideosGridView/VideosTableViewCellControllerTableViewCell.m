//
//  VideosTableViewCellControllerTableViewCell.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "VideosTableViewCellControllerTableViewCell.h"

@implementation VideosTableViewCellControllerTableViewCell
@synthesize otlLblDescription,otlLblPubDate,otlLblTitle,otlImageVideo, btnDownloadVideo;



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
-(IBAction)onClickDownloadVideo:(UIButton*)sender
{
    NSMutableDictionary *dicTagVal=[[NSMutableDictionary alloc]init];
    [dicTagVal setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"btnTag"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationOnClickDownloadVideo" object:nil userInfo:dicTagVal];
    
    
    
}
@end
