//
//  LabelVerticalAlignment.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/26/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface LabelVerticalAlignment : UILabel
@property (nonatomic, readwrite) VerticalAlignment verticalAlignment;
@end
