//
//  SearchListViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/23/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "SearchListViewController.h"
#import "DataConnection.h"
#import "WebViewDisplayData.h"
#import "WebViewDisplayLinksIphone.h"

@interface SearchListViewController ()

@end

@implementation SearchListViewController
@synthesize otlTableView;

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
    
    // Array temp For Search
    self.navigationController.navigationBarHidden=YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    UIView *viewStatusBar = [[UIView alloc] init];
    viewStatusBar.frame = CGRectMake(0, 0, 320, 20);
    viewStatusBar.backgroundColor = [UIColor colorWithRed:(243.0/255.0) green:(243.0/255.0) blue:(243.0/255.0) alpha:1.0];
    otlNavBarSearch.translucent=NO;
    otlNavBarSearch.barTintColor=[UIColor colorWithRed:(243.0/255.0) green:(243.0/255.0) blue:(243.0/255.0) alpha:1.0];
    otlNavBarSearch.tintColor=[UIColor darkGrayColor];
    [self.view addSubview:viewStatusBar];
    arrOfSubStrForAutoSuggestionJobs=[[NSMutableArray alloc]init];
    arrOfSubStrForAutoSuggestionNews= [[NSMutableArray alloc]init];
    arrOfSubStrForAutoSuggestionCaseStudies=[[NSMutableArray alloc]init];
    arrOfSubStrForAutoSuggestionWhitePapers=[[NSMutableArray alloc]init];
    
    [self createSearchOptionsArray];

    otlTableView.hidden =YES;
    self.otlTableView.sectionFooterHeight=0;
    self.otlTableView.sectionHeaderHeight=30;
   // self.otlTableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0) ;
   // self.otlTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onAlertNotification:) name:@"NotifyDownloadFailureAlert" object:nil];
    self.navigationController.navigationBarHidden=YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

    [searchBarView resignFirstResponder];
    //[searchBarView setText:@""];
    [super viewWillAppear:NO];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UISearchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar*)searchBar{
    
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
  
}
#pragma mark - UISearchbar delegates
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //[self.popoverControllerVIewFvrt dismissPopoverAnimated:YES];
   
    NSRange range=[searchBar.text rangeOfString:searchText];
    NSString *substring = [NSString stringWithString:searchBar.text];
    
    if([substring isEqualToString:@""]){
       otlTableView.hidden =YES;
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
    
    if (isEmptyTable) {
        return 1;
    }

       return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(isEmptyTable)
    {
        return 1;
    }
    else
    {
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
    if (section==3) {
        return  [arrOfSubStrForAutoSuggestionWhitePapers count];
    }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionName=nil;
//    // For Favourites
//    if (isEmptyTable)
//    {
//    }
//    else{
//        
//        switch (section)
//        {
//            case 0:
//                if([arrOfSubStrForAutoSuggestionNews count]>0) {
//                    
//                    sectionName = @"News";
//                }
//                break;
//            case 1:
//                if([arrOfSubStrForAutoSuggestionJobs count]>0){
//                    sectionName = @"Videos" ;
//                }
//                
//                break;
//            case 2:
//                if([arrOfSubStrForAutoSuggestionCaseStudies count]>0){
//                    sectionName = @"Case Studies" ;
//                }
//                
//                break;
//            case 3:
//                if([arrOfSubStrForAutoSuggestionWhitePapers count]>0){
//                    sectionName = @"White Papers" ;
//                }
//                
//                break;
//                
//                
//                // ...
//            default:
//                sectionName = @"";
//                break;
//        }
//    }
//    return sectionName;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (isEmptyTable)
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
        
   
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.numberOfLines=2;
        cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
    
    }
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0 && arrOfSubStrForAutoSuggestionNews.count>0)
    {
        return 30;
    }
    else if (section==1 && arrOfSubStrForAutoSuggestionJobs.count>0)
    {
        return 30;
    }
    else if (section==2 && arrOfSubStrForAutoSuggestionCaseStudies.count>0)
    {
        return 30;
    }
    else if (section==3 && arrOfSubStrForAutoSuggestionWhitePapers.count>0)
    {
        return 30;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor=[UIColor clearColor];
    //    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
    label.textColor=[UIColor darkGrayColor];
    if(section==0 && arrOfSubStrForAutoSuggestionNews.count>0)
    {
        label.text=@"News";;
        [view addSubview:label];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    else if (section==1 && arrOfSubStrForAutoSuggestionJobs.count>0)
    {
        label.text=@"Videos";;
        [view addSubview:label];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    else if (section==2 && arrOfSubStrForAutoSuggestionCaseStudies.count>0)
    {
        
        label.text=@"Case Studies";
        [view addSubview:label];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    else if (section==3 && arrOfSubStrForAutoSuggestionWhitePapers.count>0)
    {
        
        label.text=@"White Papers";
        [view addSubview:label];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }

    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    NSString* strSelectionType;
    NSString* strTinyUrl;
    NSString* strSourceUrl;
    NSUInteger indexOfTheObject;
    UITableViewCell *rowSelected = [tableView cellForRowAtIndexPath:indexPath];
    NSString* selectedText =  rowSelected.textLabel.text;
    
    if(!isEmptyTable){
    if (indexPath.section==0 && arrDataSourceNews.count>0) {
        
        indexOfTheObject = [titleArrayNews indexOfObject: selectedText];
        linkString =[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
        strSearchTitle=[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"News";
    }
    if(indexPath.section==1 && arrDataSourceVideos.count>0)
    {
        indexOfTheObject = [titleArrayVideos indexOfObject: selectedText];
        linkString =[[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSearchTitle=[[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceVideos objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"Videos";
    }
    if(indexPath.section==2 && arrDataSourceCaseStudies.count>0 )
    {
        indexOfTheObject = [titleArrayCaseStudies indexOfObject: selectedText];
        linkString =[[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
        strSearchTitle=[[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceCaseStudies objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"Case Studies";
    }
    if(indexPath.section==3 && arrDataSourceWhitePapers.count>0)
    {
        indexOfTheObject = [titleArrayWhitePapers indexOfObject: selectedText];
        linkString =[[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
        strSearchTitle=[[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
        strTinyUrl = [[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
        strSourceUrl=[[arrDataSourceWhitePapers objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
        strSelectionType=@"White Papers";
    }
    
    
    
    WebViewDisplayData *objWebViewDisplayData=[[WebViewDisplayData alloc]init];
    objWebViewDisplayData.strURLDisplay=linkString;
    objWebViewDisplayData.strPageTitle=strSelectionType;
    objWebViewDisplayData.strSourceURL=strSourceUrl;
    objWebViewDisplayData.strFilePath=linkString;
    objWebViewDisplayData.strTitleDisplay=strSearchTitle;
    
    if(strTinyUrl==nil||[[strTinyUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""]){
        objWebViewDisplayData.strTinyURLDisplay=strSourceUrl;
       // objWebViewDisplayData.strSourceURL=strSourceUrl;
        
    }
    else{
        objWebViewDisplayData.strTinyURLDisplay=strTinyUrl;
       // objWebViewDisplayData.strSourceURL=strTinyUrl;
    }
    
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
    NSLog(@"arrof Videos %@",titleArrayVideos);
    
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
    NSLog(@"arrof News %@",titleArrayNews);
    
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
    NSLog(@"arrof News %@",titleArrayCaseStudies);
    
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
    NSLog(@"arrof News %@",titleArrayWhitePapers);
    
    
    
}

#pragma mark - textFieldAutoSuggestion
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
        otlTableView.hidden =NO;
        CGFloat height = 70*([arrOfSubStrForAutoSuggestionNews count]+[arrOfSubStrForAutoSuggestionJobs count]+[arrOfSubStrForAutoSuggestionCaseStudies count]+[arrOfSubStrForAutoSuggestionWhitePapers count]);
        
       // [popoverView setFrame:CGRectMake(0, 0, 320, height)];
            [otlTableView setContentSize:CGSizeMake(320, height)];
       // popoverContent.preferredContentSize = CGSizeMake(320, height);
        
       // [self.popoverControllerVIew  presentPopoverFromRect:CGRectMake(0, 0, 320, 29)
                                                 //    inView:searchBarView permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  // animated:YES];
        [otlTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
    }
    
    else
    {
        otlTableView.hidden =NO;
        isEmptyTable=YES;
        CGFloat height = 70;
       [otlTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//        [popoverView setFrame:CGRectMake(0, 0, 320, height)];
       // [otlTableView setFrame:CGRectMake(0, 0, 320, height)];
        [otlTableView setContentSize:CGSizeMake(320, height)];
//        
        
        
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [searchBarView resignFirstResponder];
}
-(IBAction)cancelAction:(id)sender
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

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
