//
//  VideosGridViewControlleriPhone.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "VideosTableViewCellControllerTableViewCell.h"

@interface VideosGridViewControlleriPhone : UIViewController
{
    IBOutlet UITableView* otlVideoTableView;
    VideosTableViewCellControllerTableViewCell* objVideoCell;
    NSMutableArray *arrDataSourceVideos;
    NSArray *arrDataSourceParsedData;
    NSMutableArray *dateTemparr;

}
-(void)setTableViewFrame;
@end
