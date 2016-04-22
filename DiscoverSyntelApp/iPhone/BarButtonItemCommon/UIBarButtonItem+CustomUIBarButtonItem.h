//
//  UIBarButtonItem+CustomUIBarButtonItem.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/29/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomUIBarButtonItem)
+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage xOffset:(NSInteger)xOffset target:(id)target action:(SEL)action;

//+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title xOffset:(NSInteger)xOffset target:(id)target action:(SEL)action;

@end
