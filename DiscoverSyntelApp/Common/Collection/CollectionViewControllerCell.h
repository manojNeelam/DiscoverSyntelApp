//
//  CollectionViewControllerCell.h
//  ResourceManagement
//
//  Created by Sanjay on 9/16/13.
//  Copyright (c) 2013 Syntel MacBook 002. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewControllerCell : UICollectionViewCell
@property (nonatomic,strong)IBOutlet UILabel* titleLabel;
@property (nonatomic,strong)IBOutlet UILabel* pubDateLabel;
@property (nonatomic,strong)IBOutlet UIImageView* imageView;

@end
