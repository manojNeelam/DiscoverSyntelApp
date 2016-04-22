//
//  BaseViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/11/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "BaseViewController.h"
#import "DataConnection.h"
#import "WebViewDisplayLinks.h"
#import "VideoDisplayWebViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize popoverControllerVIew=_popoverControllerVIew, popoverControllerVIewFvrt=_popoverControllerVIewFvrt;

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
   

    // Adding NavigationBar Items on UINavigationBar
    [self showNavBarButtonItems];
    
    // Setting Navigation bar tint color
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:(243.0/255.0) green:(243.0/255.0) blue:(243.0/255.0) alpha:1.0];
        
    // Array temp For Search
    arrOfSubStrForAutoSuggestionJobs=[[NSMutableArray alloc]init];
    arrOfSubStrForAutoSuggestionNews= [[NSMutableArray alloc]init];
    arrOfSubStrForAutoSuggestionCaseStudies=[[NSMutableArray alloc]init];
    arrOfSubStrForAutoSuggestionWhitePapers=[[NSMutableArray alloc]init];
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onAlertNotification:) name:@"NotifyDownloadFailureAlert" object:nil];
    [searchBarView resignFirstResponder];
    [searchBarView setText:@""];
    [super viewWillAppear:NO];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar{
    
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.popoverControllerVIewFvrt dismissPopoverAnimated:YES];
}
#pragma mark - UISearchbar delegates
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.popoverControllerVIewFvrt dismissPopoverAnimated:YES];
    isFavouritesSelected=NO;
    NSRange range=[searchBar.text rangeOfString:searchText];
    NSString *substring = [NSString stringWithString:searchBar.text];
    
    if([substring isEqualToString:@""]){
        [self.popoverControllerVIew dismissPopoverAnimated:YES];
    }
    else{
        substring = [substring
                     stringByReplacingCharactersInRange:range withString:searchText];
      
        [self textFieldAutoSuggestion:substring];
    }
}


- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
    }


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBarView resignFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // For Favourites
    if(isFavouritesSelected)
    {
        if([[dicFavouritesFetched allKeys]count]>0){
        return [[dicFavouritesFetched allKeys] count];
        }
    }
    // For Search
    else if (isEmptyTable) {
        return 1;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // For Favourites
    if(isFavouritesSelected) {
        if([[dicFavouritesFetched allKeys]count]>0){
            NSString *strFavKey= [[dicFavouritesFetched allKeys]objectAtIndex:section];
            return [[dicFavouritesFetched valueForKey:strFavKey]count];
        }
    }
    // For Search
    else if(isEmptyTable)
    {
        return 1;
    }
    else{
    
    // Return the number of rows in the section.
    if (section==0) {
       return  [arrOfSubStrForAutoSuggestionNews count];
    }
    if (section==1) {
        return [arrOfSubStrForAutoSuggestionJobs count];
    }
    if (section==2) {
         return  [arrOfSubStrForAutoSuggestionCaseStudies count];
        
    }
     return  [arrOfSubStrForAutoSuggestionWhitePapers count];
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName=nil;
    // For Favourites
    if(isFavouritesSelected){
        return [[dicFavouritesFetched allKeys]objectAtIndex:section];
        
    }
    // For Search
    else if (isEmptyTable)
    {
    }
    else{
    
    switch (section)
    {
        case 0:
            if([arrOfSubStrForAutoSuggestionNews count]>0) {
                
                sectionName = @"News";
            }
            break;
        case 1:
            if([arrOfSubStrForAutoSuggestionJobs count]>0){
                sectionName = @"Videos" ;
            }
            
            break;
        case 2:
            if([arrOfSubStrForAutoSuggestionCaseStudies count]>0){
                sectionName = @"Case Studies" ;
            }
            
            break;
        case 3:
            if([arrOfSubStrForAutoSuggestionWhitePapers count]>0){
                sectionName = @"White Papers" ;
            }
            
            break;


            // ...
        default:
            sectionName = @"";
            break;
    }
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // For Fvaourites
    if(isFavouritesSelected){
        if([[dicFavouritesFetched allKeys]count]>0){
            NSString *strFavKey=[[dicFavouritesFetched allKeys] objectAtIndex:indexPath.section];
            if([[dicFavouritesFetched valueForKey:strFavKey]count]>0){
                cell.textLabel.text=[[[dicFavouritesFetched valueForKey:strFavKey]objectAtIndex:indexPath.row]valueForKey:favouriteTitleKey];
            }
        }
    }
    // For Search
    else if (isEmptyTable)
    {
        cell.textLabel.text = @"No results found";
    }
    else{
        if (indexPath.section==0 && [arrOfSubStrForAutoSuggestionNews count]>indexPath.row) {
            cell.textLabel.text=[arrOfSubStrForAutoSuggestionNews objectAtIndex:indexPath.row];
        }
        if (indexPath.section==1  && [arrOfSubStrForAutoSuggestionJobs count]>indexPath.row) {
            cell.textLabel.text=[arrOfSubStrForAutoSuggestionJobs objectAtIndex:indexPath.row];
        }
        if (indexPath.section==2 && [arrOfSubStrForAutoSuggestionCaseStudies count]>indexPath.row) {
            cell.textLabel.text=[arrOfSubStrForAutoSuggestionCaseStudies objectAtIndex:indexPath.row];
        }
        if (indexPath.section==3  && [arrOfSubStrForAutoSuggestionWhitePapers count]>indexPath.row) {
            cell.textLabel.text=[arrOfSubStrForAutoSuggestionWhitePapers objectAtIndex:indexPath.row];
        }
        
    }
    cell.textLabel.numberOfLines=0;
    cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.textLabel.font=[UIFont fontWithName:@"System-Bold" size:16];
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger indexOfTheObject;
    UITableViewCell *rowSelected = [tableView cellForRowAtIndexPath:indexPath];
    NSString* selectedText =  rowSelected.textLabel.text;
    NSString* strSelectionType;
    NSString* strFavTitle;
    NSString* strTinyUrl;
    NSString* strSourceUrl;
    
    // For Favourites
    if(isFavouritesSelected){
        NSString *strKey=[[dicFavouritesFetched allKeys] objectAtIndex:indexPath.section];
        linkString=[[[dicFavouritesFetched valueForKey:strKey]objectAtIndex:indexPath.row]valueForKey:@"favouriteLink"];
        strFavTitle=[[[dicFavouritesFetched valueForKey:strKey]objectAtIndex:indexPath.row]valueForKey:@"favouriteTitle"];
        
        if([strKey isEqualToString:TechnicalOfferings]||[strKey isEqualToString:IndustrialOfferings]){
          strSelectionType=strFavTitle;
        }
        else{
          strSelectionType=strKey;
        }
        
        
        strTinyUrl=[[[dicFavouritesFetched valueForKey:strKey]objectAtIndex:indexPath.row]valueForKey:@"favouriteTinyUrl"];
        strSourceUrl=strTinyUrl;
        [self.popoverControllerVIewFvrt dismissPopoverAnimated:YES];
    }
    else if (isEmptyTable)
    {
        [self.popoverControllerVIew dismissPopoverAnimated:YES];
        
    }
    // For Search
    else{
    if (indexPath.section==0) {

      indexOfTheObject = [titleArrayNews indexOfObject: selectedText];
        linkString =[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
        strSearchTitle=[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"News";
    }
    if(indexPath.section==1)
    {
        indexOfTheObject = [titleArrayVideos indexOfObject: selectedText];
        linkString =[[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSearchTitle=[[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"Videos";
    }
    if(indexPath.section==2)
    {
        indexOfTheObject = [titleArrayCaseStudies indexOfObject: selectedText];
        linkString =[[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
        strSearchTitle=[[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"Case Studies";
    }
    if(indexPath.section==3)
    {
        indexOfTheObject = [titleArrayWhitePapers indexOfObject: selectedText];
        linkString =[[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
        strSearchTitle=[[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
         strTinyUrl = [[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"White Papers";
    }
    }
   
    [self.popoverControllerVIew dismissPopoverAnimated:YES];
    NSMutableDictionary *objSearchDictionary=[[NSMutableDictionary alloc]init];
    [objSearchDictionary setValue:linkString forKey:@"URL"];
    [objSearchDictionary setValue:strSelectionType forKey:@"PageTitle"];
    
    if(strTinyUrl==nil||[[strTinyUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
       [objSearchDictionary setValue:strSourceUrl forKeyPath:@"tinyURL"];
    }
    else
    {
       [objSearchDictionary setValue:strTinyUrl forKeyPath:@"tinyURL"];
    }
    
   // [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationPauseVideo" object:nil userInfo:nil];
    if(isFavouritesSelected){
       [objSearchDictionary setValue:strFavTitle forKey:@"Title"];
        
    }
    else if (isEmptyTable)
    {
        [self.popoverControllerVIew dismissPopoverAnimated:YES];
    }

    else{
        [objSearchDictionary setValue:strSearchTitle forKey:@"Title"];
    }
    NSMutableDictionary *dicPauseVideo=[NSMutableDictionary dictionary];
    [dicPauseVideo setValue:strSelectionType forKey:@"keyType"];
    if(isFavouritesSelected){
    if([[[dicFavouritesFetched allKeys] objectAtIndex:indexPath.section] isEqualToString:IndustrialOfferings]||[[[dicFavouritesFetched allKeys] objectAtIndex:indexPath.section] isEqualToString:TechnicalOfferings]){
        NSMutableDictionary *dicNotification=[[NSMutableDictionary alloc]initWithObjectsAndKeys:objSearchDictionary,@"ContentDic", nil];
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationPauseVideo" object:nil userInfo:dicPauseVideo];
        
         [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationSearchLinkSelection" object:nil userInfo:dicNotification];
        
        return;
    }
       
        
    }
    

        
        DataConnection *objDataConnection=[[DataConnection alloc]init];
        if([objDataConnection networkConnection])
        {
            if (!(isEmptyTable)) {
                NSMutableDictionary *dicNotification=[[NSMutableDictionary alloc]initWithObjectsAndKeys:objSearchDictionary,@"ContentDic", nil];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationPauseVideo" object:nil userInfo:dicPauseVideo];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationSearchLinkSelection" object:nil userInfo:dicNotification];
            }
           
            }



    
}

#pragma mark - Autosuggestion message

-(void)createSearchOptionsArray
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedData=appDelegate.arrChangeSetParsedData;
    // arrDataSourceVideos=[[NSMutableArray alloc]init];
    NSMutableArray *arrTemp=[NSMutableArray array];
    
    
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"Videos"])
        {
            if([objDic valueForKey:@"Videos"]!=nil){
                [arrTemp addObject:[objDic valueForKey:@"Videos"]];}
        }
    }
    titleArrayVideos = [[NSMutableArray alloc]init];
    arrDataSourceVideos=[arrTemp objectAtIndex:0];
    for (int i=0; i<[arrDataSourceVideos count]; i++) {
        if([[arrDataSourceVideos objectAtIndex:i]valueForKey:@"Title"]!=nil){
            [titleArrayVideos addObject: [[arrDataSourceVideos objectAtIndex:i]valueForKey:@"Title"]];}
        
    }
   
    
    //for newsArray
    
    NSMutableArray *arrTempNews=[NSMutableArray array];
    
    
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"News"])
        {
            if([objDic valueForKey:@"News"]!=nil){
                [arrTempNews addObject:[objDic valueForKey:@"News"]];}
        }
    }
    titleArrayNews = [[NSMutableArray alloc]init];
    arrDataSourceNews=[arrTempNews objectAtIndex:0];
    for (int i=0; i<[arrDataSourceNews count]; i++) {
        if([[arrDataSourceNews objectAtIndex:i]valueForKey:@"Title"]!=nil){
        [titleArrayNews addObject: [[arrDataSourceNews objectAtIndex:i]valueForKey:@"Title"]];
        }
        
    }
   
    
    //for caseStudies array
    
    
    NSMutableArray *arrTempCaseStudies=[NSMutableArray array];
    
    
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"CaseStudies"])
        {
            if([objDic valueForKey:@"CaseStudies"]!=nil){
                [arrTempCaseStudies addObject:[objDic valueForKey:@"CaseStudies"]];}
        }
    }
    titleArrayCaseStudies = [[NSMutableArray alloc]init];
    arrDataSourceCaseStudies=[arrTempCaseStudies objectAtIndex:0];
    for (int i=0; i<[arrDataSourceCaseStudies count]; i++) {
        if([[arrDataSourceCaseStudies objectAtIndex:i]valueForKey:@"Title"]!=nil){
        [titleArrayCaseStudies addObject: [[arrDataSourceCaseStudies objectAtIndex:i]valueForKey:@"Title"]];
        }
        
    }
   
    //for whitepapers array
    
    
    NSMutableArray *arrTempWhitePapers=[NSMutableArray array];
    
    
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"Whitepapers"])
        {
            if([objDic valueForKey:@"Whitepapers"]!=nil){
                [arrTempWhitePapers addObject:[objDic valueForKey:@"Whitepapers"]];}
        }
    }
    titleArrayWhitePapers = [[NSMutableArray alloc]init];
    arrDataSourceWhitePapers=[arrTempWhitePapers objectAtIndex:0];
    for (int i=0; i<[arrDataSourceWhitePapers count]; i++) {
        ;
        [titleArrayWhitePapers addObject: [[arrDataSourceWhitePapers objectAtIndex:i]valueForKey:@"Title"]];
        
    }
   
    


}

-(void)createPopoverView
{
    popoverContent = [[UIViewController alloc]init];
    tblViewMenu = [[UITableView alloc]init];
    tblViewMenu.frame=CGRectMake(0, 0, 320, 300);
    tblViewMenu.delegate = self;
    tblViewMenu.dataSource =self;
    popoverContent.view = tblViewMenu;
    popoverContent.preferredContentSize = CGSizeMake(320, tblViewMenu.frame.size.height);

    self.popoverControllerVIew = [[UIPopoverController alloc]
                                  initWithContentViewController:popoverContent];
  
}

-(void)textFieldAutoSuggestion:(NSString*)subStr
{
    [arrOfSubStrForAutoSuggestionJobs removeAllObjects];
    [arrOfSubStrForAutoSuggestionNews removeAllObjects];
    [arrOfSubStrForAutoSuggestionCaseStudies removeAllObjects];
    [arrOfSubStrForAutoSuggestionWhitePapers removeAllObjects];
    
    //matching with videos array
    for(NSString *currentString in titleArrayVideos) {
        NSRange substringRange = [currentString rangeOfString:subStr options:NSCaseInsensitiveSearch];
        if (substringRange.location== NSNotFound)
        {
            
        }
        else{
            [arrOfSubStrForAutoSuggestionJobs addObject:currentString];
        }
    }
 
    //matching news array
    for(NSString *currentString in titleArrayNews) {
        NSRange substringRange = [currentString rangeOfString:subStr options:NSCaseInsensitiveSearch];
        if (substringRange.location== NSNotFound)
        {
            
        }
        else{
            [arrOfSubStrForAutoSuggestionNews addObject:currentString];
        }
    }

    //matching caseStudies array
    for(NSString *currentString in titleArrayCaseStudies) {
        NSRange substringRange = [currentString rangeOfString:subStr options:NSCaseInsensitiveSearch];
        if (substringRange.location== NSNotFound)
        {
            
        }
        else{
            [arrOfSubStrForAutoSuggestionCaseStudies addObject:currentString];
        }
    }
    

    //matching whitePapers array
    for(NSString *currentString in titleArrayWhitePapers) {
        NSRange substringRange = [currentString rangeOfString:subStr options:NSCaseInsensitiveSearch];
        if (substringRange.location== NSNotFound)
        {
            
        }
        else{
            [arrOfSubStrForAutoSuggestionWhitePapers addObject:currentString];
        }
    }
    

    
    
    // sorting mutable array of matching substrings
    [arrOfSubStrForAutoSuggestionJobs sortUsingSelector:@selector(compare:)];
    [arrOfSubStrForAutoSuggestionNews sortUsingSelector:@selector(compare:)];
    [arrOfSubStrForAutoSuggestionCaseStudies sortUsingSelector:@selector(compare:)];
    [arrOfSubStrForAutoSuggestionWhitePapers sortUsingSelector:@selector(compare:)];
    
    if(([arrOfSubStrForAutoSuggestionJobs count]>0 )||([arrOfSubStrForAutoSuggestionNews count]>0 )||([arrOfSubStrForAutoSuggestionCaseStudies count]>0 )||([arrOfSubStrForAutoSuggestionWhitePapers count]>0 )){
         isEmptyTable=NO;
        CGFloat height = 70*([arrOfSubStrForAutoSuggestionNews count]+[arrOfSubStrForAutoSuggestionJobs count]+[arrOfSubStrForAutoSuggestionCaseStudies count]+[arrOfSubStrForAutoSuggestionWhitePapers count]);
        
        [popoverView setFrame:CGRectMake(0, 0, 320, height)];
        //[tblViewMenu setFrame:CGRectMake(0, 0, 320, height)];
        [tblViewMenu setContentSize:CGSizeMake(320, height)];
        popoverContent.preferredContentSize = CGSizeMake(320, height);
        
        [self.popoverControllerVIew  presentPopoverFromRect:CGRectMake(0, 0, 320, 29)
                                                     inView:searchBarView permittedArrowDirections:UIPopoverArrowDirectionUp
                                                animated:YES];
        [tblViewMenu performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

    }
    
    else
    {
        isEmptyTable=YES;
        CGFloat height = 70;
        [tblViewMenu performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [popoverView setFrame:CGRectMake(0, 0, 320, height)];
        //[tblViewMenu setFrame:CGRectMake(0, 0, 320, height)];
        [tblViewMenu setContentSize:CGSizeMake(320, height)];
        
        popoverContent.preferredContentSize = tblViewMenu.contentSize;
        
        [self.popoverControllerVIew  presentPopoverFromRect:CGRectMake(0, 0, 320, 29)
                                                     inView:searchBarView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        

       
    }
}

#pragma mark - UIBarButtonItems
-(void)showNavBarButtonItems
{
    
    // Checking the images for retina display
    UIImage *imageBackBtn=nil;
    UIImage *imageFavourites=nil;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
        // Retina Display
        imageBackBtn=[[UIImage imageNamed:@"HomeIcon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageFavourites=[[UIImage imageNamed:@"FavoritesIcon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else{
        // Non-Retina Display
        imageBackBtn=[[UIImage imageNamed:@"HomeIcon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageFavourites=[[UIImage imageNamed:@"FavoritesIcon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    
    if([self.navigationController viewControllers].count==1){
        // For Home Screen
        self.navigationItem.hidesBackButton=YES;
    }
    else if([self.navigationController viewControllers].count==2){
       // For View controllers next to Home screen in view controller hierarchy, custom back button is created
        self.navigationItem.hidesBackButton=YES;
        UIBarButtonItem  *backButtonHome=[[UIBarButtonItem alloc]initWithImage:imageBackBtn style:UIBarButtonItemStylePlain target:self action:@selector(onClickHomeIcon:)];
        self.navigationItem.leftBarButtonItem=backButtonHome;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
        
        // Setting backBarButton item title for next view controllers in hierarchy
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem=backButton;
        self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    }
    // Adding Favourites and Search Bar to the NavigationBar
    [self addFavouritesNavBarIconWithImage:imageFavourites];
    [self addSearchNavBarIcon];
    NSArray *arrOfBarBtnItems=[[NSArray alloc]initWithObjects:barBtnFavourites,barBtnSearch, nil];
    self.navigationItem.rightBarButtonItems=arrOfBarBtnItems;
    [self createSearchOptionsArray];
    [self createPopoverView];

}
-(void)addFavouritesNavBarIconWithImage:(UIImage*)iconFavourites
{
    barBtnFavourites=[[UIBarButtonItem alloc]initWithImage:iconFavourites style:UIBarButtonItemStylePlain target:self action:@selector(onClickFavourites:)];
}
-(void)addSearchNavBarIcon
{
    searchBarView = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,200,40)];
    searchBarView.delegate=(id)self;
    barBtnSearch=[[UIBarButtonItem alloc] initWithCustomView:searchBarView];
   
}


# pragma mark - BarButtonItemAction
-(void)onClickHomeIcon:(UIBarButtonItem*)sender
{
   
    if(self.popoverControllerVIew!=nil)
    {
        [self.popoverControllerVIew dismissPopoverAnimated:YES];
    }
    if(self.popoverControllerVIewFvrt!=nil)
    {
        [self.popoverControllerVIewFvrt dismissPopoverAnimated:YES];
        
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)onClickFavourites:(id)sender
{
    isFavouritesSelected=YES;
    dicFavouritesFetched=[self creatingDictionaryForFavourites];
    
    // UIPopOver on click of favourites bar button item
    CGFloat height = 70*([[dicFavouritesFetched valueForKey:WhitePapers] count]+[[dicFavouritesFetched valueForKey:CaseStudies] count]+[[dicFavouritesFetched valueForKey:Videos] count]+[[dicFavouritesFetched valueForKey:IndustrialOfferings] count]+[[dicFavouritesFetched valueForKey:TechnicalOfferings] count]+[[dicFavouritesFetched valueForKey:News] count]);
    
    popoverContentFvrt = [[UIViewController alloc]init];
    tblViewFvrt = [[UITableView alloc]init];
    tblViewFvrt.contentSize = CGSizeMake(320, height);
    [tblViewFvrt setFrame:CGRectMake(0, 0, 320, height)];
    tblViewFvrt.sectionHeaderHeight=30;
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:[UIFont boldSystemFontOfSize:19]];
    popoverContent.preferredContentSize = CGSizeMake(320, tblViewFvrt.frame.size.height);
    
    if([[dicFavouritesFetched valueForKey:CaseStudies]count]==0&&[[dicFavouritesFetched valueForKey:IndustrialOfferings]count]==0&&[[dicFavouritesFetched valueForKey:TechnicalOfferings]count]==0&&[[dicFavouritesFetched valueForKey:Videos]count]==0&&[[dicFavouritesFetched valueForKey:WhitePapers]count]==0&&[[dicFavouritesFetched valueForKey:News]count]==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"No Favourites Found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        tblViewFvrt.delegate = self;
        tblViewFvrt.dataSource =self;
        popoverContentFvrt.view = tblViewFvrt;
        popoverContentFvrt.preferredContentSize = CGSizeMake(320, height);
        
        self.popoverControllerVIewFvrt = [[UIPopoverController alloc]
                                          initWithContentViewController:popoverContentFvrt];
        
        [self.popoverControllerVIewFvrt presentPopoverFromBarButtonItem:barBtnFavourites permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
}


#pragma mark - Favourites
-(NSMutableArray*)fetchFavouritesList
{
    AppDelegate* appDelegateObj = APP_INSTANCE;
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
  //  NSMutableArray *arrTinyUrl=[[NSMutableArray alloc]init];
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


-(void)onAlertNotification:(NSNotification*)notification
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Download failed." delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel",nil];
    retryDict = [[NSDictionary alloc]init];
    retryDict = notification.userInfo;
    [alert show];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotifyDownloadFailureAlert" object:nil];

}


#pragma mark - UIInterfaceOrientation



@end
