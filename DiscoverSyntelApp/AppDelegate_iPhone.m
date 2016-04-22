//
//  AppDelegate_iPhone.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/14/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "AppDelegate_iPhone.h"

@implementation AppDelegate_iPhone
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
    UIViewController *vc =[storybord instantiateInitialViewController];
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
