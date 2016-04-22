//
//  VideosTableViewCellControllerTableViewCell.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideosTableViewCellControllerTableViewCell : UITableViewCell
{
    
    IBOutlet UILabel *otlLblTitle;
    IBOutlet UILabel *otlLblPubDate;
    IBOutlet UILabel *otlLblDescription;
    IBOutlet UIImageView *otlImageVideo;
    IBOutlet UIButton* btnDownloadVideo;
    
}
@property(nonatomic,strong)UILabel *otlLblTitle;
@property(nonatomic,strong)UILabel *otlLblPubDate;
@property(nonatomic,strong)UILabel *otlLblDescription;
@property(nonatomic,strong)UIImageView *otlImageVideo;
@property (nonatomic,strong)IBOutlet UIButton* btnDownloadVideo;
-(IBAction)onClickDownloadVideo:(UIButton*)sender;

@end
