//
//  PDFListCell.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/16/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "PDFListCell.h"

@implementation PDFListCell

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
-(IBAction)onClickDownload:(UIButton*)sender
{

    NSMutableDictionary *dicTagVal=[[NSMutableDictionary alloc]init];
    [dicTagVal setValue:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"btnTag"];
    [dicTagVal setValue:sender forKey:@"senderObj"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationOnclickDownload" object:nil userInfo:dicTagVal];
}
@end
