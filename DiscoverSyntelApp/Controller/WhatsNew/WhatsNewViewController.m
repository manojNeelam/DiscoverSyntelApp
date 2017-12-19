//
//  WhatsNewViewController.m
//  DiscoverSyntelApp
//
//  Created by reema on 22/04/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhatsNewViewController.h"
#import "AppDelegate.h"
#import "WebViewDisplayLinks.h"
#import "ListItemTableViewController.h"
#import "VideoDisplayWebViewController.h"
#import "DataConnection.h"

@interface WhatsNewViewController ()

@end

@implementation WhatsNewViewController

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
    self.title=@"What's New";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedDataWhatsNew=appDelegate.arrChangeSetParsedData;
    NSMutableArray *arrTempDataSource=[[NSMutableArray alloc]init];
    for (NSDictionary *objDic in arrDataSourceParsedDataWhatsNew) {
       if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"WhatsNew"])
        {
           
            [arrTempDataSource addObject:[objDic valueForKey:@"WhatsNew"]];
        }
    }
    
    arrDataSourceWhatsNewList=[arrTempDataSource objectAtIndex:0];
    if(arrDataSourceWhatsNewList.count>0){
    otlLblContentNotAvailable.hidden=YES;
    ListItemTableViewController* listItemTableViewController = [[ListItemTableViewController alloc]initWithStyle:UITableViewStylePlain andListArray:arrDataSourceWhatsNewList andButton:nil andIdentifier:@"WhatsNew"];
    listItemTableViewController.tableView.scrollEnabled=YES;
    listItemTableViewController.tableView.contentSize=CGSizeMake(728, [arrDataSourceWhatsNewList count]*130+80);
    listItemTableViewController.tableView.contentInset = UIEdgeInsetsMake(30,20,50,-40);

    listItemTableViewController.delegate=self;
    [self.view addSubview:listItemTableViewController.view];
    [self addChildViewController:listItemTableViewController];
    
    listItemTableViewController.delegate=self;
    [self.view addSubview:listItemTableViewController.view];
    [self addChildViewController:listItemTableViewController];
	// Do any additional setup after loading the view.
    
    //add notification for reloading data
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(whatsNewReload:) name:@"reloadWhatsNew" object:nil];
    }
    else{
        otlLblContentNotAvailable.hidden=NO;
    }
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
-(void) selectedItemDetails:(NSMutableDictionary*) dicvalue
{
  //  linkStringToPass=[dicvalue valueForKey:@"LocationPath"];
    linkStringToPass=[dicvalue valueForKey:@"tinyURL"];// changes //
    strTitleToPass=[dicvalue valueForKey:@"Title"];
    dicContentReceived=dicvalue;
    
    NSMutableDictionary *dicContent=[[NSMutableDictionary alloc]init];
    [dicContent setValue:nil forKey:@"FilePath"];
    [dicContent setValue:linkStringToPass forKey:@"URL"];
    [dicContent setValue:linkStringToPass forKey:@"SourceUrl"];
    [dicContent setValue:[dicContentReceived valueForKey:@"tinyURL"] forKey:@"tinyURL"];
    [dicContent setValue:[dicContentReceived valueForKey:@"Category"] forKey:@"PageTitle"];
    [dicContent setValue:strTitleToPass forKey:@"Title"];
    
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection]){
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    if([[dicContentReceived valueForKey:@"Category"] isEqualToString:@"Videos"])
    {
        
        VideoDisplayWebViewController *objVideoDisplayWebViewController=(VideoDisplayWebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"VideoDisplayWebViewController"];
        objVideoDisplayWebViewController.dicOfContentLoaded=dicContent;
        [self.navigationController pushViewController:objVideoDisplayWebViewController animated:NO];
    }
    else{
        //WebViewDisplayLinks
        WebViewDisplayLinks *objWebViewDisplayLinks=(WebViewDisplayLinks*)[mainStoryboard instantiateViewControllerWithIdentifier:@"WebViewDisplayLinks"];
        objWebViewDisplayLinks.dicOfContentLoaded=dicContent;
        [self.navigationController pushViewController:objWebViewDisplayLinks animated:NO];
    }
    }

}
# pragma mark - UIInterfaceOrientation
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

-(void)whatsNewReload:(NSNotification*)notification
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedDataWhatsNew=appDelegate.arrChangeSetParsedData;
    NSMutableArray *arrTempDataSource=[[NSMutableArray alloc]init];
    for (NSDictionary *objDic in arrDataSourceParsedDataWhatsNew) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"WhatsNew"])
        {
            
            [arrTempDataSource addObject:[objDic valueForKey:@"WhatsNew"]];
        }
    }
    
    arrDataSourceWhatsNewList=[arrTempDataSource objectAtIndex:0];
  
    ListItemTableViewController* listItemTableViewController = [[ListItemTableViewController alloc]initWithStyle:UITableViewStylePlain andListArray:arrDataSourceWhatsNewList andButton:nil andIdentifier:@"WhatsNew"];
   // [listItemTableViewController.view setFrame:CGRectMake(20, 20, 760-40, [arrDataSourceWhatsNewList count]*118+100)];
    listItemTableViewController.tableView.contentSize=CGSizeMake(728, [arrDataSourceWhatsNewList count]*130+80);
    listItemTableViewController.tableView.contentInset = UIEdgeInsetsMake(30,20,50,-40);

   // listItemTableViewController.tableView.contentInset = UIEdgeInsetsMake(0,0,100,0);
    listItemTableViewController.delegate=self;
    [self.view addSubview:listItemTableViewController.view];
    [self addChildViewController:listItemTableViewController];
	

}

@end
