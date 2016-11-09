//
//  contactHeaderiPadView.h
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/22/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contactHeaderiPadView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSep;
@property (weak, nonatomic) IBOutlet UIButton *btnToggleCell;
@property (weak, nonatomic) IBOutlet UIImageView *imgToggle;

@end
