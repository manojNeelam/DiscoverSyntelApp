//
//  PDFListCelliPhone.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFListCelliPhone : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView *otlImageView;
@property(nonatomic,strong)IBOutlet UILabel *otlLabel;
@property(nonatomic,strong)IBOutlet UIButton *otlBtnDownLoad;
@property(nonatomic,strong)IBOutlet UILabel *otlLabelTitle;

-(IBAction)onClickDownload:(id)sender;
@end
