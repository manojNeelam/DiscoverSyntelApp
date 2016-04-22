//
//  NewsListViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/10/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "NewsListViewController.h"
#import "AppDelegate.h"
#import "XMLParserController.h"
#import "ListItemTableViewController.h"
#import "WebViewDisplayLinks.h"
#import "DataConnection.h"

@interface NewsListViewController ()

@end

@implementation NewsListViewController
@synthesize strIdentifierFolder,_otlTableNewsList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //http://172.29.36.52:1212/HTML/IndustryOfferings/BNFS/IO_BNFS_000_Main.html
     
       
        
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
  
 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onContentUpdation:) name:@"NotificationContentUpdation" object:nil];
    
    //to remove table default empty top
  
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedDataNews=appDelegate.arrChangeSetParsedData;
    //arrDataSourceNewsList=[[NSMutableArray alloc]init];
    NSMutableArray *arrTempDataSource=[[NSMutableArray alloc]init];
    for (NSDictionary *objDic in arrDataSourceParsedDataNews) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"News"])
        {
            [arrTempDataSource addObject:[objDic valueForKey:@"News"]];
        }
    }
  
    arrDataSourceNewsList=[arrTempDataSource objectAtIndex:0];
    //Fetching files from document directory according to the string Identifier received from home screen
    
   
    
    ListItemTableViewController* listItemTableViewController = [[ListItemTableViewController alloc]initWithStyle:UITableViewStylePlain andListArray:arrDataSourceNewsList andButton:nil andIdentifier:@"News"];
    listItemTableViewController.tableView.scrollEnabled=YES;
    listItemTableViewController.tableView.contentSize=CGSizeMake(728, [arrDataSourceNewsList count]*130+80);
    listItemTableViewController.tableView.contentInset = UIEdgeInsetsMake(30,20,50,-40);
    listItemTableViewController.delegate=self;
    [self.view addSubview:listItemTableViewController.view];
    [self addChildViewController:listItemTableViewController];
   
}
-(void)viewWillAppear:(BOOL)animated
{
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSMutableDictionary *dicContent=[[NSMutableDictionary alloc]init];
    

    
    [dicContent setValue:nil forKey:@"FilePath"];
    [dicContent setValue:linkStringToPass forKey:@"URL"];
    [dicContent setValue:linkStringToPass forKey:@"SourceUrl"];
    [dicContent setValue:strTinyUrl forKey:@"tinyURL"];
    [dicContent setValue:@"News" forKey:@"PageTitle"];
    [dicContent setValue:strTitleToPass forKey:@"Title"];
    
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection])
    {
    
    WebViewDisplayLinks *objWebViewDisplayLinks=(WebViewDisplayLinks*)segue.destinationViewController;
    objWebViewDisplayLinks.dicOfContentLoaded=dicContent;
    }
    // objWebViewDisplayLinks.strUrlIndustryOfferings=linkStringToPass;
    // objWebViewDisplayLinks.strWebViewTitle=@"News";
    
}
#pragma mark - Notification Handler
-(void)onContentUpdation:(NSNotification*)notification
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"msg" message:@"xml downloaded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark - Action Events
-(void)parsingUpdatedXML:(id)sender
{
    XMLParserController *objXMLParserController=[[XMLParserController alloc]init];
    [objXMLParserController parseXML];
  //[otlTableNewsList reloadData];
}

#pragma mark - ListItemProtocol Methods

-(void) selectedItemDetails:(NSMutableDictionary*)dicValue
{
    linkStringToPass=[dicValue valueForKey:@"LocationPath"];
    strTitleToPass=[dicValue valueForKey:@"Title"];
    strTinyUrl=[dicValue valueForKey:@"tinyURL"];
    [self performSegueWithIdentifier:@"IndustryOfferingsSegue" sender:nil];

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
