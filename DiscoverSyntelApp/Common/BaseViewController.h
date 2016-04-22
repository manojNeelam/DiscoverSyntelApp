//
//  BaseViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/11/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UIBarButtonItem *barBtnFavourites;
    UIBarButtonItem *barBtnSearch;
    UISearchBar *searchBarView;
    NSArray *arrDataSourceParsedData;
    NSMutableArray *arrDataSourceVideos;
    NSMutableArray* arrDataSourceNews;
    NSMutableArray* arrDataSourceCaseStudies;
    NSMutableArray* arrDataSourceWhitePapers;
    
    
    NSMutableArray* titleArrayVideos;
    NSMutableArray* titleArrayNews;
    NSMutableArray* titleArrayCaseStudies;
    NSMutableArray* titleArrayWhitePapers;
    
    NSMutableArray *arrOfSubStrForAutoSuggestionJobs;
    NSMutableArray* arrOfSubStrForAutoSuggestionNews;
    NSMutableArray* arrOfSubStrForAutoSuggestionCaseStudies;
    NSMutableArray* arrOfSubStrForAutoSuggestionWhitePapers;
    
    NSString* linkString;
       // For Search
    NSString* strSearchTitle;
    UIViewController* popoverContent;
    UIView* popoverView ;
    UITableView *tblViewMenu;
    // For Favourites
    UIViewController* popoverContentFvrt;
    UIView* popoverViewFvrt ;
    UITableView* tblViewFvrt;
       BOOL isEmptyTable;
   
    BOOL isFavouritesSelected; //Bool value distinguishing between favourites and search
    NSMutableDictionary *dicFavouritesFetched; //dic holding favourites data
    NSDictionary* retryDict;
}

@property(nonatomic,strong) UIPopoverController* popoverControllerVIew; // For Search
@property(nonatomic,strong) UIPopoverController* popoverControllerVIewFvrt;// For Favourites
-(void)createPopoverView;
-(void) createSearchOptionsArray;
-(void)onClickFavourites:(id)sender;

@end
