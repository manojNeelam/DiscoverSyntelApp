//
//  BaseViewControllerIphone.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "BaseViewControllerIphone.h"
#import "ModalListViewController.h"
#import "WebViewDisplayLinksIphone.h"
#import "DataConnection.h"
#import "UIBarButtonItem+CustomUIBarButtonItem.h"

@interface BaseViewControllerIphone ()

@end

@implementation BaseViewControllerIphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showNavigationBar];
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onClickFavouritesButton:) name:@"NotificationFavouriteSelection" object:nil];
   // [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showNavigationBar
{
    // Setting Navigation bar tint color
    NSLog(@"view controller array:%@",self.navigationController.viewControllers);
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:(243.0/255.0) green:(243.0/255.0) blue:(243.0/255.0) alpha:1.0];
    
        if([self.navigationController viewControllers].count==1){
        // For Home Screen
        self.navigationItem.hidesBackButton=YES;
        self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    }
    else if([self.navigationController viewControllers].count==2&&![[self.navigationController.viewControllers objectAtIndex:1]isKindOfClass:[WebViewDisplayLinksIphone class]]){
        // For View controllers next to Home screen in view controller hierarchy, custom back button is created
        self.navigationItem.hidesBackButton=YES;
        UIBarButtonItem  *backButtonHome=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"HomeIconIphone@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickHomeIcon:)];
        self.navigationItem.leftBarButtonItem=backButtonHome;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        
        // Setting backBarButton item title for next view controllers in hierarchy
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem=backButton;
        self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    }
    else{
       // self.navigationItem.hidesBackButton=YES;
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem=backButton;
        self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    }
    
    UIBarButtonItem* barButtonSearch = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"SearchIconIphone@2x.png"] highlightedImage:[UIImage imageNamed:@"SearchIconIphone@2x.png"]  xOffset:8 target:self  action:@selector(onClickSearchBarButton:)];
    
    UIBarButtonItem* barButtonFavourite = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"FavoritesIconIphone@2x.png"] highlightedImage:[UIImage imageNamed:@"FavoritesIconIphone@2x.png"]  xOffset:11 target:self  action:@selector(onClickFavouriteBarButton:)];
    
    NSArray *arrBarButtonItems=[[NSArray alloc]initWithObjects:barButtonFavourite,barButtonSearch,nil];
    self.navigationItem.rightBarButtonItems=arrBarButtonItems;
   /*
   UIBarButtonItem *barButtonSearch=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"SearchIconIphone@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickSearchBarButton:)];
    
    UIBarButtonItem *barButtonFavourite=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"FavoritesIconIphone@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickFavouriteBarButton:)];
    
    UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeparator.width = -12;
 
    NSArray *arrBarButtonItems=[[NSArray alloc]initWithObjects: negativeSeparator,barButtonFavourite,barButtonSearch,nil];
    self.navigationItem.rightBarButtonItems=arrBarButtonItems;
    */

    
}
#pragma mark - UIBarButtonItemAction
-(void)onClickSearchBarButton:(UIBarButtonItem*)sender
{
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    SearchListViewController* searchListViewController = [storyboard instantiateViewControllerWithIdentifier:@"SearchListViewControlleriPhone"];
    UINavigationController *navControllerSearch=[[UINavigationController alloc]initWithRootViewController:searchListViewController];
    
    [self presentViewController:navControllerSearch animated:YES completion:nil];
}
-(void)onClickFavouriteBarButton:(UIBarButtonItem*)sender
{
    dicFavouritesFetched=[self creatingDictionaryForFavourites];
    
    if([[dicFavouritesFetched valueForKey:CaseStudies]count]==0&&[[dicFavouritesFetched valueForKey:IndustrialOfferings]count]==0&&[[dicFavouritesFetched valueForKey:TechnicalOfferings]count]==0&&[[dicFavouritesFetched valueForKey:Videos]count]==0&&[[dicFavouritesFetched valueForKey:WhitePapers]count]==0&&[[dicFavouritesFetched valueForKey:News]count]==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"No Favourites Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
	ModalListViewController *objModalListViewController = [storyboard instantiateViewControllerWithIdentifier:@"ModalListViewController"];
        objModalListViewController.dicMarkedFavourites=dicFavouritesFetched;
    
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:objModalListViewController];
    [self presentViewController:navController animated:YES completion:nil];
    }
}
-(void)onClickHomeIcon:(UIBarButtonItem*)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - Favourites
-(NSMutableArray*)fetchFavouritesList
{
    AppDelegate_iPhone* appDelegateObj = APP_INSTANCE_IPHONE;
    NSManagedObjectContext* managedContextObj = [appDelegateObj managedObjectContext];
    
    // Define entity to use
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedContextObj];
    
    // Setup the fetch request
    NSFetchRequest* fetchRequestObj =[[NSFetchRequest alloc] init ];
    [fetchRequestObj setEntity:entityDescription];
    
    NSError* errorObj = nil;
    NSArray *arrFavouriesManagedContext = [managedContextObj executeFetchRequest:fetchRequestObj error:&errorObj];
    return [arrFavouriesManagedContext mutableCopy];
    
}
-(NSMutableDictionary*)creatingDictionaryForFavourites
{
    NSMutableDictionary *dicFavouritesTemp=[NSMutableDictionary dictionary];
    NSMutableArray *arrFavouritesTemp= [self fetchFavouritesList];
    NSMutableArray *arrFavVideo=[[NSMutableArray alloc]init];
    NSMutableArray *arrFavTechnologyOfferings=[[NSMutableArray alloc]init];
    NSMutableArray *arrFavWhitepapers=[[NSMutableArray alloc]init];
    NSMutableArray *arrFavCaseStudies=[[NSMutableArray alloc]init];
    NSMutableArray *arrFavIndustryOfferings=[[NSMutableArray alloc]init];
    NSMutableArray *arrFavNews=[[NSMutableArray alloc]init];
    for (id obj in arrFavouritesTemp) {
        if([[obj valueForKey:favouriteTypeKey]isEqualToString:WhitePapers])
        {
            [arrFavWhitepapers addObject:obj];
        }
        else if ([[obj valueForKey:favouriteTypeKey]isEqualToString:CaseStudies])
        {
            [arrFavCaseStudies addObject:obj];
        }
        else if ([[obj valueForKey:favouriteTypeKey]isEqualToString:Videos])
        {
            [arrFavVideo addObject:obj];
        }
        else if ([[obj valueForKey:favouriteTypeKey]isEqualToString:IndustrialOfferings])
        {
            [arrFavIndustryOfferings addObject:obj];
        }
        else if ([[obj valueForKey:favouriteTypeKey]isEqualToString:TechnicalOfferings])
        {
            [arrFavTechnologyOfferings addObject:obj];
        }
        else if ([[obj valueForKey:favouriteTypeKey]isEqualToString:News])
        {
            [arrFavNews addObject:obj];
            
        }
        
    }
    if([arrFavWhitepapers count]>0){
        [dicFavouritesTemp setValue:arrFavWhitepapers forKey:WhitePapers];}
    if([arrFavCaseStudies count]>0){
        [dicFavouritesTemp setValue:arrFavCaseStudies forKey:CaseStudies];}
    if([arrFavVideo count]>0){
        [dicFavouritesTemp setValue:arrFavVideo forKey:Videos];}
    if([arrFavIndustryOfferings count]>0){
        [dicFavouritesTemp setValue:arrFavIndustryOfferings forKey:IndustrialOfferings];}
    if([arrFavTechnologyOfferings count]>0){
        [dicFavouritesTemp setValue:arrFavTechnologyOfferings forKey:TechnicalOfferings];}
    if([arrFavNews count]>0){
        [dicFavouritesTemp setValue:arrFavNews forKey:News];
    }
    
    return dicFavouritesTemp;
}


@end
