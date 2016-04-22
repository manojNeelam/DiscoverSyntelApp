//
//  IndustrialOfferingsViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/23/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface IndustrialOfferingsViewController : BaseViewController
{
    NSMutableArray *arrOfferingsMenu;
    int indexValueInArray;
    BOOL isMenuOptionSelected;
    NSMutableDictionary *dictionaryContenets;
}

-(IBAction)onClickOfferings:(id)sender;

@end
