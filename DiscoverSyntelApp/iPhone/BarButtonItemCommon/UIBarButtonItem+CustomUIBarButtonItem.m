//
//  UIBarButtonItem+CustomUIBarButtonItem.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/29/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "UIBarButtonItem+CustomUIBarButtonItem.h"

@implementation UIBarButtonItem (CustomUIBarButtonItem)
+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage xOffset:(NSInteger)xOffset target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, xOffset, 0, -xOffset)];
    }
    
    UIBarButtonItem *customUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return customUIBarButtonItem;
}

//+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title xOffset:(NSInteger)xOffset target:(id)target action:(SEL)action
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [button setFrame:CGRectMake(0, 0, [button.titleLabel.text sizeWithFont:button.titleLabel.font].width + 3, 24)];
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
//        [button setContentEdgeInsets:UIEdgeInsetsMake(0, xOffset, 0, -xOffset)];
//    }
//    
//    UIBarButtonItem *customUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    return customUIBarButtonItem;
//}

@end
