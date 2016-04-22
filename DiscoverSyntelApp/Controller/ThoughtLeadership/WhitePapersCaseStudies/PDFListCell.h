//
//  PDFListCell.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/16/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFListCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *otlImageView;
@property(nonatomic,strong)IBOutlet UILabel *otlLabel;
@property(nonatomic,strong)IBOutlet UIButton *otlBtnDownLoad;
@property(nonatomic,strong)IBOutlet UILabel *otlLabelTitle;

-(IBAction)onClickDownload:(id)sender;
@end
