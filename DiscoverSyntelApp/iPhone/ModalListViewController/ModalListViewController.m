//
//  ModalListViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ModalListViewController.h"
#import "WebViewDisplayLinksIphone.h"
#import "DataConnection.h"

@interface ModalListViewController ()

@end

@implementation ModalListViewController
@synthesize objFavouriteTable;
@synthesize arrOfValues,arrOfImages,dicMarkedFavourites;
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
    self.navigationController.navigationBarHidden=YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    UIView *viewStatusBar = [[UIView alloc] init];
    viewStatusBar.frame = CGRectMake(0, 0, 320, 20);
    viewStatusBar.backgroundColor = [UIColor colorWithRed:(243.0/255.0) green:(243.0/255.0) blue:(243.0/255.0) alpha:1.0];
    otlNavBar.translucent=NO;
    otlNavBar.barTintColor=[UIColor colorWithRed:(243.0/255.0) green:(243.0/255.0) blue:(243.0/255.0) alpha:1.0];
    otlNavBar.tintColor=[UIColor darkGrayColor];
    objFavouriteTable.rowHeight=45;
    objFavouriteTable.sectionHeaderHeight=30;
    isModalViewControllerLoaded=NO;
    self.objFavouriteTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.objFavouriteTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:viewStatusBar];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    self.navigationController.navigationBarHidden=YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    if(isModalViewControllerLoaded){
    self.dicMarkedFavourites=[self creatingDictionaryForFavourites];
    [objFavouriteTable reloadData];
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    isModalViewControllerLoaded=YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([[dicMarkedFavourites allKeys]count]>0){
        return [[dicMarkedFavourites allKeys] count];
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[dicMarkedFavourites allKeys]count]>0){
        NSString *strFavKey= [[dicMarkedFavourites allKeys]objectAtIndex:section];
        return [[dicMarkedFavourites valueForKey:strFavKey]count];
    }
    return 0;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    return [[dicMarkedFavourites allKeys]objectAtIndex:section];
//        
//    
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
        if([[dicMarkedFavourites allKeys]count]>0){
            NSString *strFavKey=[[dicMarkedFavourites allKeys] objectAtIndex:indexPath.section];
            if([[dicMarkedFavourites valueForKey:strFavKey]count]>0){
                cell.textLabel.text=[[[dicMarkedFavourites valueForKey:strFavKey]objectAtIndex:indexPath.row]valueForKey:favouriteTitleKey];
                cell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
                cell.textLabel.numberOfLines=2;
                if([[[dicMarkedFavourites allKeys]objectAtIndex:indexPath.section]isEqualToString:News])
                {
                    cell.imageView.image=[UIImage imageNamed:@"NewsSymbolIphone@2x.png"];
                }
                else if ([[[dicMarkedFavourites allKeys]objectAtIndex:indexPath.section]isEqualToString:Videos])
                {
                    cell.imageView.image=[UIImage imageNamed:@"VideoSymbolIphone@2x.png"];
                }
                else if ([[[dicMarkedFavourites allKeys]objectAtIndex:indexPath.section]isEqualToString:TechnicalOfferings]){
                    cell.imageView.image=[UIImage imageNamed:@"TechnologyOfferingsSymbolIphone@2x.png"];
                    
                }
                else if ([[[dicMarkedFavourites allKeys]objectAtIndex:indexPath.section]isEqualToString:WhitePapers]||[[[dicMarkedFavourites allKeys]objectAtIndex:indexPath.section]isEqualToString:CaseStudies]){
                    cell.imageView.image=[UIImage imageNamed:@"PdfSymbolIphone@2x.png"];
                    
                }
                else if ([[[dicMarkedFavourites allKeys]objectAtIndex:indexPath.section]isEqualToString:IndustrialOfferings])
                {
                    cell.imageView.image=[UIImage imageNamed:@"IndustryOfferingsSymbolIphone@2x.png"];
                }
            }
            
        }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
  
    NSString* strSelectionType;
    NSString* strTinyUrl;
    NSString* strSourceUrl;
    
    NSString *strKey=[[dicMarkedFavourites allKeys] objectAtIndex:indexPath.section];
    NSString *linkString=[[[dicMarkedFavourites valueForKey:strKey]objectAtIndex:indexPath.row]valueForKey:@"favouriteLink"];
    NSString *strFavTitle=[[[dicMarkedFavourites valueForKey:strKey]objectAtIndex:indexPath.row]valueForKey:@"favouriteTitle"];
    
    if([strKey isEqualToString:TechnicalOfferings]||[strKey isEqualToString:IndustrialOfferings]){
        strSelectionType=strFavTitle;
    }
    else{
        strSelectionType=strKey;
    }
    
    
    strTinyUrl=[[[dicMarkedFavourites valueForKey:strKey]objectAtIndex:indexPath.row]valueForKey:@"favouriteTinyUrl"];
    strSourceUrl=strTinyUrl;
    objWebViewDisplayData=[[WebViewDisplayData alloc]init];
    
   /* if([linkString rangeOfString:@"Library/Caches/download"].location==NSNotFound){
        objWebViewDisplayData.strURLDisplay=linkString;
        objWebViewDisplayData.strFilePath=linkString;
    }
    else{
        objWebViewDisplayData.strURLDisplay=strTinyUrl;
        objWebViewDisplayData.strFilePath=strTinyUrl;

    }
    */
    
    objWebViewDisplayData.strURLDisplay=linkString;
    objWebViewDisplayData.strFilePath=linkString;

    objWebViewDisplayData.strPageTitle=strSelectionType;
    objWebViewDisplayData.strSourceURL=strTinyUrl;
    objWebViewDisplayData.strTitleDisplay=strFavTitle;
    
    if(strTinyUrl==nil||[[strTinyUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""]){
        objWebViewDisplayData.strTinyURLDisplay=strSourceUrl;
    }
    else{
        objWebViewDisplayData.strTinyURLDisplay=strTinyUrl;
    }
    if([[[dicMarkedFavourites allKeys] objectAtIndex:indexPath.section] isEqualToString:IndustrialOfferings]||[[[dicMarkedFavourites allKeys] objectAtIndex:indexPath.section] isEqualToString:TechnicalOfferings]){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
        objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebViewDisplayData;
        [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];}
    else
    {
        DataConnection *objDataConnection=[[DataConnection alloc]init];
        if([objDataConnection networkConnection])
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
            WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
            objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebViewDisplayData;
            [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
        }
        
    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor=[UIColor clearColor];
//    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
    label.textColor=[UIColor darkGrayColor];
    label.text=[[dicMarkedFavourites allKeys]objectAtIndex:section];
    [view addSubview:label];
    return view;
    }


#pragma mark - Action Handlers
-(IBAction)onClickCancel:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - UIInterfaceOrientation
-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
#define supportedInterfaceOrientationsReturnType NSUInteger
#else
#define supportedInterfaceOrientationsReturnType UIInterfaceOrientationMask
#endif

- (supportedInterfaceOrientationsReturnType)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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

@end
