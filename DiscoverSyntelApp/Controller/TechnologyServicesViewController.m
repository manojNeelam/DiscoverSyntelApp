//
//  TechnologyServicesViewController.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 12/15/16.
//  Copyright © 2016 Mobile Computing. All rights reserved.
//
#define HEIGHT_HEADER_VIEW 65


#import "TechnologyServicesViewController.h"
#import "TechnologyServicesData.h"
#import "WebViewDisplayData.h"
#import "WebViewDisplayLinksIphone.h"
#import "WebViewDisplayLinks.h"

@interface TechnologyServicesViewController ()<UIGestureRecognizerDelegate>
{
    NSMutableArray *technologyServiceList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TechnologyServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    [self.navigationItem setTitle:@"Technology Services"];
    
    technologyServiceList = [[NSMutableArray alloc] init];//WithArray:[self loadData]];
    technologyServiceList = [self loadData];
    isMenuOptionSelected=NO;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isMenuOptionSelected=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return technologyServiceList.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, HEIGHT_HEADER_VIEW)];
    baseView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, baseView.frame.size.width-40, HEIGHT_HEADER_VIEW)];
    TechnologyServicesData *industrySolData = [technologyServiceList objectAtIndex:section];
    [lbl setText:industrySolData.title];
    [lbl setTextColor:[UIColor blackColor]];
    [baseView addSubview:lbl];
    
    UITapGestureRecognizer *singleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [singleTapRecogniser setDelegate:self];
    singleTapRecogniser.numberOfTouchesRequired = 1;
    singleTapRecogniser.numberOfTapsRequired = 1;
    [baseView addGestureRecognizer:singleTapRecogniser];
    
    UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_HEADER_VIEW-1, tableView.frame.size.width, 1)];
    [sepLabel setText:@""];
    [sepLabel setBackgroundColor:[UIColor lightGrayColor]];
    [baseView addSubview:sepLabel];
    
    UIImageView *leftIndicatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-45, 20, 25, 25)];
    [leftIndicatorImg setImage:[UIImage imageNamed:@"leftArrow@1x"]];
    [baseView addSubview:leftIndicatorImg];
    
    baseView.tag = section;
    return baseView;
}

- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = gestureRecognizer.view;
    TechnologyServicesData *technologySerData = [technologyServiceList objectAtIndex:view.tag];
    
    NSString *filePath = [self fetchFilePath:technologySerData.key];
    
    WebViewDisplayData *objWebDisplayData = [[WebViewDisplayData alloc]init];
    objWebDisplayData.strPageTitle = technologySerData.title;
    
    objWebDisplayData.strSourceURL = technologySerData.tinyURL;
    objWebDisplayData.strTinyURLDisplay = technologySerData.tinyURL;
    
    objWebDisplayData.strURLDisplay = filePath;
    objWebDisplayData.strFilePath = filePath;
    objWebDisplayData.strTitleDisplay = technologySerData.title;
    
    if(!isMenuOptionSelected)
    {
        [self pushView:objWebDisplayData];
        isMenuOptionSelected = YES;
    }
    
    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
//    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
//    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebDisplayData;
//    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*NSString *CellIdentifier = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell ==  nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftArrow@1x"]];
    TechnologyServicesData *technologySerData = [technologyServiceList objectAtIndex:indexPath.row];
    [cell.textLabel setText:technologySerData.title];*/
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_HEADER_VIEW;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TechnologyServicesData *technologySerData = [technologyServiceList objectAtIndex:indexPath.row];
    
    NSString *filePath = [self fetchFilePath:technologySerData.key];
    
    WebViewDisplayData *objWebDisplayData = [[WebViewDisplayData alloc]init];
    objWebDisplayData.strPageTitle = technologySerData.title;
    
    objWebDisplayData.strSourceURL = technologySerData.tinyURL;
    objWebDisplayData.strTinyURLDisplay = technologySerData.tinyURL;
    
    objWebDisplayData.strURLDisplay = filePath;
    objWebDisplayData.strFilePath = filePath;
    objWebDisplayData.strTitleDisplay = technologySerData.title;
    
    
    if(!isMenuOptionSelected)
    {
        [self pushView:objWebDisplayData];
        isMenuOptionSelected = YES;
    }
    
    
    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
//    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
//    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebDisplayData;
//    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;//technologyServiceList.count;
}

-(void)pushView:(WebViewDisplayData *)webViewData
{
    
    
    /*
     
     NSString *strURLDisplay;
     NSString *strTinyURLDisplay;
     NSString *strTitleDisplay;
     NSString *strDescriptionDisplay;
     NSString *strPubDateDisplay;
     NSString *strPageTitle;
     NSString *strSourceURL;
     NSString *strFilePath;
     
     
     indexOfTheObject = [titleArrayNews indexOfObject: selectedText];
     linkString =[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"LocationPath"];
     strSearchTitle=[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"Title"];
     strTinyUrl = [[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"tinyURL"];
     strSourceUrl=[[arrDataSourceNews objectAtIndex:indexOfTheObject]valueForKey:@"Source"];
     */
    
    dictionaryContenets=[[NSMutableDictionary alloc]init];
    [dictionaryContenets setValue:webViewData.strSourceURL forKey:@"SourceUrl"];
    
    [dictionaryContenets setValue:webViewData.strTitleDisplay forKey:@"Title"];
    [dictionaryContenets setValue:webViewData.strFilePath forKey:@"FilePath"];
    
    [dictionaryContenets setValue:webViewData.strURLDisplay  forKey:@"URL"];
    [dictionaryContenets setValue:webViewData.strPageTitle forKey:@"PageTitle"];
    [dictionaryContenets setValue:webViewData.strTinyURLDisplay forKey:@"tinyURL"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    WebViewDisplayLinks *objWebViewDisplayLinks = (WebViewDisplayLinks*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinks"];
    objWebViewDisplayLinks.dicOfContentLoaded=dictionaryContenets;
    [self.navigationController pushViewController:objWebViewDisplayLinks animated:YES];
    //isMenuOptionSelected=YES;
}

-(NSMutableArray *)loadData
{
    NSMutableArray *dummy = [NSMutableArray array];
    TechnologyServicesData *technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Application Lifecycle";
    technologySerData.key = @"ALC";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/application-lifecycle";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Cloud";
    technologySerData.key = @"Cloud";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/cloud";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Data & Insights";
    technologySerData.key = @"DI";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/data-and-insights";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Syntel Digital One";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/syntel-digital-one";
    technologySerData.key = @"DO";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Enterprise Solutions";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/enterprise-solutions";
    technologySerData.key = @"ERS";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"IT Infrastructure Management";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/it-infrastructure-management";
    technologySerData.key = @"ITM";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Legacy Modernization";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/legacy-modernization";
    technologySerData.key = @"LM";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Mobility Solutions";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/mobility-solutions";
    technologySerData.key = @"MOB";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Testing";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/testing";
    technologySerData.key = @"Testing";
    [dummy addObject:technologySerData];
    
    return dummy;
}


-(NSString*)fetchFilePath:(NSString*)directoryName
{
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    
    NSError * error;
    NSString *directoryHtml=[NSString stringWithFormat:@"%@%@",[[documentDirURL path] stringByAppendingString:@"/Webcontent/HTML/"],[TechnologyOfferingsFolder stringByAppendingPathComponent:directoryName]];
    NSArray *directoryContents =  [[NSFileManager defaultManager]
                                   contentsOfDirectoryAtPath:directoryHtml error:&error];
    NSString *strfilePath;
    for (id file in directoryContents) {
        NSString *filesHtml=[NSString stringWithFormat:@"%@%@%@",directoryHtml,@"/",file];
        if([filesHtml rangeOfString:@"Main.html"].location == NSNotFound){
            // file not found
            strfilePath=nil;
        }
        else{
            strfilePath=filesHtml;
            break;
        }
    }
    
    return strfilePath;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
