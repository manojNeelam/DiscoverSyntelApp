//
//  DownloadViewCelliPhone.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadViewCelliPhone : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *otlImgDownload;
@property(nonatomic,strong)IBOutlet UILabel *otlLblFileName;
@property(nonatomic,strong)IBOutlet UIButton *otlBtnDeleteDownload;
-(IBAction)onClickDeleteDownloads:(UIButton*)sender;

@end
