//
//  DownloadCellController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/26/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCellController : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *otlImgDownload;
@property(nonatomic,strong)IBOutlet UILabel *otlLblFileName;
@property(nonatomic,strong)IBOutlet UIButton *otlBtnDeleteDownload;
-(IBAction)onClickDeleteDownloads:(UIButton*)sender;
@end
