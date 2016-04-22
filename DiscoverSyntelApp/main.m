//
//  main.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/10/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "AppDelegate_iPhone.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        else
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate_iPhone class]));
    }
}
