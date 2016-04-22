//
//  SearchListViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/23/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchListViewController : UIViewController
{
    NSArray *arrDataSourceParsedData;
    NSMutableArray *arrDataSourceVideos;
    NSMutableArray* arrDataSourceNews;
    NSMutableArray* arrDataSourceCaseStudies;
    NSMutableArray* arrDataSourceWhitePapers;
    

    NSMutableArray *arrOfSubStrForAutoSuggestionJobs;
    NSMutableArray* arrOfSubStrForAutoSuggestionNews;
    NSMutableArray* arrOfSubStrForAutoSuggestionCaseStudies;
    NSMutableArray* arrOfSubStrForAutoSuggestionWhitePapers;
    
    NSMutableArray* titleArrayVideos;
    NSMutableArray* titleArrayNews;
    NSMutableArray* titleArrayCaseStudies;
    NSMutableArray* titleArrayWhitePapers;
    
    NSString* linkString;
    NSString* strSearchTitle;
    IBOutlet UINavigationBar *otlNavBarSearch;
   IBOutlet  UISearchBar *searchBarView;
    IBOutlet UITableView* otlTableView;
    
     BOOL isEmptyTable;
}
@property(nonatomic,retain) IBOutlet UITableView* otlTableView;

-(IBAction)cancelAction:(id)sender;
@end
