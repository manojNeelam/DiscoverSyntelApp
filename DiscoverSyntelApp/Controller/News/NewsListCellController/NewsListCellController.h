//
//  NewsListCellController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListCellController : UITableViewCell
{
    IBOutlet UILabel *otlLblTitle;
    IBOutlet UILabel *otlLblPubDate;
    IBOutlet UILabel *otlLblDescription;
    IBOutlet UIImageView *otlImg;
}

@property(nonatomic,strong)UILabel *otlLblTitle;
@property(nonatomic,strong)UILabel *otlLblPubDate;
@property(nonatomic,strong)UILabel *otlLblDescription;
@property(nonatomic,strong)UIImageView *otlImg;

@end
