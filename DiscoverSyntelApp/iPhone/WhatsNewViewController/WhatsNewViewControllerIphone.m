//
//  WhatsNewViewControllerIphone.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhatsNewViewControllerIphone.h"
#import "WebViewDisplayData.h"
#import "WebViewDisplayLinksIphone.h"
#import "DataConnection.h"


@interface WhatsNewViewControllerIphone ()

@end

@implementation WhatsNewViewControllerIphone

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
    // Do any additional setup after loading the view.
    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    NSArray *arrDataSourceParsedDataWhatsNew=appDelegate.arrChangeSetParsedData;
    //arrDataSourceNewsList=[[NSMutableArray alloc]init];
    NSMutableArray *arrTempDataSource=[[NSMutableArray alloc]init];
    for (NSDictionary *objDic in arrDataSourceParsedDataWhatsNew) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"WhatsNew"])
        {
            [arrTempDataSource addObject:[objDic valueForKey:@"WhatsNew"]];
        }
    }
    //self.title=@"Whats New";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 0.0, 50, 44)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    label.textAlignment=NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    [label setText:@"What's New"];
    self.navigationItem.titleView = label;
    otlTableViewWhatsNew.rowHeight=140;
    otlTableViewWhatsNew.separatorStyle=UITableViewCellSeparatorStyleNone;
    otlTableViewWhatsNew.contentInset = UIEdgeInsetsMake(10,0,64,0);
    arrWhatsNewDataSource=[arrTempDataSource objectAtIndex:0];
    //add notification for reloading data
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(whatsNewReload:) name:@"reloadWhatsNew" object:nil];
    
    
    if(arrWhatsNewDataSource.count>0){
        otlLblContentNotAvailable.hidden=YES;
    }
    else{
        otlLblContentNotAvailable.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrWhatsNewDataSource count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"WhatsNewControllerCell";
    objWhatsNewControllerCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (objWhatsNewControllerCell == nil)
    {
        objWhatsNewControllerCell=[[[NSBundle mainBundle]loadNibNamed:@"WhatsNewControllerCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    objWhatsNewControllerCell.selectionStyle=UITableViewCellSelectionStyleNone;
    objWhatsNewControllerCell.backgroundColor=[UIColor clearColor];
    
    
    if(arrWhatsNewDataSource.count>0){
        objWhatsNewControllerCell.otlLblTitle.text=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Title"];
        objWhatsNewControllerCell.otlLblPubDate.text=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
        objWhatsNewControllerCell.otlLblDescription.text=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Description"];
        if([[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"Videos"]||[[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"Whitepapers"]||[[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"CaseStudies"])
        {
            objWhatsNewControllerCell.otlImageWhatsNew.image=[UIImage imageNamed:@"ThoughtLeadershipSymbol.png"];
        }
        else if ([[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"News"])
        {
            objWhatsNewControllerCell.otlImageWhatsNew.image=[UIImage imageNamed:@"NewsSymbol.png"];
        }

        
    }
    
    
    return objWhatsNewControllerCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strOfURL=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"LocationPath"];
  //  NSString *strOfURL=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Source"];
    NSString *strOfTinyURL=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"tinyURL"];
    
    WebViewDisplayData *objWebViewDisplayData=[[WebViewDisplayData alloc]init];
  //  objWebViewDisplayData.strURLDisplay=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
   if( [[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"Videos"]){
       objWebViewDisplayData.strPageTitle=@"Videos";
    }
   else if ([[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"Whitepapers"]){
       objWebViewDisplayData.strPageTitle=@"Whitepapers";
   }
   else if ([[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"CaseStudies"]){
       objWebViewDisplayData.strPageTitle=@"CaseStudies";
   }
    else if ([[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Category"]isEqualToString:@"News"])
    {
        objWebViewDisplayData.strPageTitle=@"News";
    }
   // objWebViewDisplayData.strFilePath=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strFilePath=strOfURL;
    objWebViewDisplayData.strTitleDisplay=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Title"];
    objWebViewDisplayData.strPubDateDisplay=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
    objWebViewDisplayData.strDescriptionDisplay=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Description"];
    objWebViewDisplayData.strSourceURL=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Source"];
   
    
    //  objWebViewDisplayData.strURLDisplay=strOfURL;
    objWebViewDisplayData.strURLDisplay=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Source"]; // changes //
    
    
    if(strOfTinyURL==nil||[[strOfTinyURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
      //  objWebViewDisplayData.strTinyURLDisplay=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        objWebViewDisplayData.strTinyURLDisplay=[[arrWhatsNewDataSource objectAtIndex:indexPath.row]valueForKey:@"Source"];
    }
    else
    {
       // objWebViewDisplayData.strTinyURLDisplay=[strOfTinyURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        objWebViewDisplayData.strTinyURLDisplay=strOfTinyURL;
    }
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection]){
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebViewDisplayData;
    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
    }
    
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

-(void)whatsNewReload:(NSNotification*)notification
{
    AppDelegate_iPhone *appDelegate=[[UIApplication sharedApplication]delegate];
   NSArray *arrDataSourceParsedDataWhatsNew=appDelegate.arrChangeSetParsedData;
    NSMutableArray *arrTempDataSource=[[NSMutableArray alloc]init];
    for (NSDictionary *objDic in arrDataSourceParsedDataWhatsNew) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"WhatsNew"])
        {
            
            [arrTempDataSource addObject:[objDic valueForKey:@"WhatsNew"]];
        }
    }
    
   arrWhatsNewDataSource=[arrTempDataSource objectAtIndex:0];
    [otlTableViewWhatsNew reloadData];
    
}
	

@end
