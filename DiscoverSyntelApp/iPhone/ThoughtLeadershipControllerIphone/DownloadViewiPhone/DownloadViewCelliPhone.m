//
//  DownloadViewCelliPhone.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "DownloadViewCelliPhone.h"

@implementation DownloadViewCelliPhone
@synthesize otlBtnDeleteDownload, otlImgDownload, otlLblFileName;

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
-(IBAction)onClickDeleteDownloads:(UIButton *)sender
{
    int tagVal=(int)sender.tag;
    NSMutableDictionary *dicTag=[[NSMutableDictionary alloc]init];
    [dicTag setValue:[NSString stringWithFormat:@"%d",tagVal] forKey:@"DeleteBtnTag"];
    NSMutableDictionary *dicNotification=[[NSMutableDictionary alloc]init];
    [dicNotification setValue:dicTag forKey:@"Notification"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationDeleteDownloadFile" object:nil userInfo:dicNotification];
    
}

@end
