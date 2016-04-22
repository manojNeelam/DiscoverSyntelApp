//
//  NewsViewControllerCell.h
//  DiscoverSyntelApp
//
//  Created by reema on 17/05/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewControllerCell : UITableViewCell
{
    IBOutlet UILabel *otlLblTitle;
    IBOutlet UILabel *otlLblPubDate;
    IBOutlet UILabel *otlLblDescription;
   
}

@property(nonatomic,strong)UILabel *otlLblTitle;
@property(nonatomic,strong)UILabel *otlLblPubDate;
@property(nonatomic,strong)UILabel *otlLblDescription;


@end
