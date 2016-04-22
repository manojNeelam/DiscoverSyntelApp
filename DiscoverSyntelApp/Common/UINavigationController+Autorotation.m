//
//  UINavigationController+Autorotation.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "UINavigationController+Autorotation.h"

@implementation UINavigationController (Autorotation)
/*
- (void)viewDidLoad
{
    __weak UINavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate =(id) weakSelf;
        self.delegate =(id) weakSelf;
    }
}

// Hijack the push method to disable the gesture

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}
*/

-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    if ([self.topViewController supportedInterfaceOrientations] == UIInterfaceOrientationMaskAll) {
        return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    
    return [self.topViewController supportedInterfaceOrientations];
}


@end
