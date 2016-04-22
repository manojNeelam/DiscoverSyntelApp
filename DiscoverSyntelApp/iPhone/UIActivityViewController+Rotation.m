//
//  UIActivityViewController+Rotation.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 6/4/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "UIActivityViewController+Rotation.h"

@implementation UIActivityViewController (Rotation)
#pragma mark - UIInterfaceOrientation
-(BOOL)shouldAutorotate
{
    return YES;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
//}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
