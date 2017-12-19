//
//  NewsViewController.m
//  DiscoverSyntelApp
//
//  Created by reema on 17/05/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "NewsViewController.h"
#import "WebViewDisplayData.h"
#import "WebViewDisplayLinksIphone.h"
#import "DataConnection.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

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
    AppDelegate_iPhone *appDelegate=(AppDelegate_iPhone *)[[UIApplication sharedApplication]delegate];
   NSArray *arrDataSourceParsedDataNews=appDelegate.arrChangeSetParsedData;
    //arrDataSourceNewsList=[[NSMutableArray alloc]init];
    NSMutableArray *arrTempDataSource=[[NSMutableArray alloc]init];
    for (NSDictionary *objDic in arrDataSourceParsedDataNews) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"News"])
        {
            [arrTempDataSource addObject:[objDic valueForKey:@"News"]];
        }
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 0.0, 50, 44)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    label.textAlignment=NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    [label setText:@"News"];
    self.navigationItem.titleView = label;
   // self.title=@"News";
    otlTableViewNews.rowHeight=140;
    otlTableViewNews.separatorStyle=UITableViewCellSeparatorStyleNone;
    otlTableViewNews.contentInset = UIEdgeInsetsMake(10,0,64,0);
    arrNewsDataSource=[arrTempDataSource objectAtIndex:0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrNewsDataSource count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"NewsViewControllerCell";
    objNewsViewControllerCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (objNewsViewControllerCell == nil)
    {
        objNewsViewControllerCell=[[[NSBundle mainBundle]loadNibNamed:@"NewsViewControllerCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    objNewsViewControllerCell.selectionStyle=UITableViewCellSelectionStyleNone;
    objNewsViewControllerCell.backgroundColor=[UIColor clearColor];
    
    
    if(arrNewsDataSource.count>0){
        objNewsViewControllerCell.otlLblTitle.text=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"Title"];
        objNewsViewControllerCell.otlLblPubDate.text=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
        objNewsViewControllerCell.otlLblDescription.text=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"Description"];
    }
    
    
    return objNewsViewControllerCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strOfURL=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"Source"];
    NSString *strOfTinyURL=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"tinyURL"];
    
    WebViewDisplayData *objWebViewDisplayData=[[WebViewDisplayData alloc]init];
    objWebViewDisplayData.strURLDisplay=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strPageTitle=@"News";
    objWebViewDisplayData.strFilePath=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strTitleDisplay=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"Title"];
    objWebViewDisplayData.strPubDateDisplay=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
    objWebViewDisplayData.strDescriptionDisplay=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"Description"];
    objWebViewDisplayData.strSourceURL=[[arrNewsDataSource objectAtIndex:indexPath.row]valueForKey:@"Source"];
    if(strOfTinyURL==nil||[[strOfTinyURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        objWebViewDisplayData.strTinyURLDisplay=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        objWebViewDisplayData.strTinyURLDisplay=[strOfTinyURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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

@end
