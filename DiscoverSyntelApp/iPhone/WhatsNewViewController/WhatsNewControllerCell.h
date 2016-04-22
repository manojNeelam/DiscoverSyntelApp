//
//  WhatsNewControllerCell.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhatsNewControllerCell : UITableViewCell
{
    IBOutlet UILabel *otlLblTitle;
    IBOutlet UILabel *otlLblPubDate;
    IBOutlet UILabel *otlLblDescription;
    IBOutlet UIImageView *otlImageWhatsNew;

}
@property(nonatomic,strong)UILabel *otlLblTitle;
@property(nonatomic,strong)UILabel *otlLblPubDate;
@property(nonatomic,strong)UILabel *otlLblDescription;
@property(nonatomic,strong)UIImageView *otlImageWhatsNew;
@end
