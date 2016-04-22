//
//  TechnologyOfferingsViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/23/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TechnologyOfferingsViewController : BaseViewController
{
    NSMutableArray *arrOfferingsMenu;
    int indexValueInArray;
    NSMutableDictionary *dictionaryContenets;
    BOOL isMenuOptionSelected;
}

-(IBAction)onClickOfferings:(id)sender;

@end
