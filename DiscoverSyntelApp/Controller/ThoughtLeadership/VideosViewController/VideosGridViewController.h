//
//  VideosGridViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewControllerCell.h"
#import "UIImageView+AFNetworking.h"

@interface VideosGridViewController : UIViewController<UIAlertViewDelegate>
{
    NSArray *arrDataSourceParsedData;
    NSMutableArray *dateTemparr;
    NSMutableArray *arrDataSourceVideos;
    IBOutlet UICollectionView *otlCollectionViewVideo;
    CollectionViewControllerCell *objCollectionViewControllerCell;
    float numOfSections;
    int numOfItems;
    int selectedRow;
    NSDictionary* retryDict;
    
    NSMutableArray* imageDataArray;
}

@end
