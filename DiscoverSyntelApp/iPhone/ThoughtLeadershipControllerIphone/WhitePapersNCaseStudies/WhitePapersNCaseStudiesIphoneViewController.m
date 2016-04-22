//
//  WhitePapersNCaseStudiesIphoneViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhitePapersNCaseStudiesIphoneViewController.h"
#import "DataConnection.h"
#import "XMLDownload.h"
#import "WebViewDisplayData.h"
#import "WebViewDisplayLinks.h"

@interface WhitePapersNCaseStudiesIphoneViewController ()

@end

@implementation WhitePapersNCaseStudiesIphoneViewController
@synthesize strIdentifier, otlTableViewPDF, objPDFListCell;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onClickDownloadBtn:) name:@"NotificationOnclickDownload" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onCompleteDownload:) name:@"NotificationCompleteDownload" object:nil];
    
    NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
    strUserDefault=[objUserDefault valueForKey:@"SelectedValue"];
    otlTableViewPDF.separatorStyle=UITableViewCellSeparatorStyleNone;
    if([strUserDefault isEqualToString:WhitePapers])
    {
        strIdentifier=@"Whitepapers";
    }
    else if ([strUserDefault isEqualToString:CaseStudies])
    {
        strIdentifier=@"CaseStudies";
    }
    [self setDictionaryValues];
    [self setTableViewFrames];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
    strUserDefault=[objUserDefault valueForKey:@"SelectedValue"];
    
    if([strUserDefault isEqualToString:WhitePapers])
    {
        strIdentifier=@"Whitepapers";
    
    }
    else if ([strUserDefault isEqualToString:CaseStudies])
    {
        strIdentifier=@"CaseStudies";
    }
    [self setDictionaryValues];
    [self setTableViewFrames];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setDictionaryValues
{
    NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
    strUserDefault=[objUserDefault valueForKey:@"SelectedValue"];
    NSString *strTemp;
    if([strUserDefault isEqualToString:WhitePapers])
    {
        strTemp=@"Whitepapers";
        
    }
    else if ([strUserDefault isEqualToString:CaseStudies])
    {
        strTemp=@"CaseStudies";
    }

    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    arrDataSourceParsedData=appDelegate.arrChangeSetParsedData;
    //arrDataSourcePDF=[[NSMutableArray alloc]init];
    NSMutableArray *arrTemp=[NSMutableArray array];
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:strTemp])
        {
            [arrTemp addObject:[objDic valueForKey:strTemp]];
        }
    }
    arrDataSourcePDF=[arrTemp objectAtIndex:0];

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[self setDictionaryValues];
    return [arrDataSourcePDF count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"PDFListCelliPhoneIdentifier";
    objPDFListCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (objPDFListCell == nil)
    {
        objPDFListCell=[[[NSBundle mainBundle]loadNibNamed:@"PDFListCelliPhone" owner:self options:nil] objectAtIndex:0];
    }
    objPDFListCell.selectionStyle=UITableViewCellSelectionStyleNone;
    objPDFListCell.backgroundColor=[UIColor clearColor];
    
    
    if(arrDataSourcePDF.count>0)
    {
        objPDFListCell.otlBtnDownLoad.tag=indexPath.row;
        objPDFListCell.otlLabel.text=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Description"];
        objPDFListCell.otlLabelTitle.text=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Title"];
    }
    
    
    return objPDFListCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebViewDisplayData *objWebViewDisplayData=[[WebViewDisplayData alloc]init];
    NSString *strOfURL=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"LocationPath"];
    NSString *strOfSourceURL=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Source"];
    NSString *strOfTinyURL=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"];
    
    objWebViewDisplayData.strURLDisplay= [strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strFilePath=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
    objWebViewDisplayData.strPageTitle=[objUserDefault valueForKey:@"SelectedValue"];
    

    objWebViewDisplayData.strSourceURL=[strOfSourceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strTitleDisplay=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Title"];
    
    // setting source url if tiny url is empty
   
    if([[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"]==nil||[[[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
        objWebViewDisplayData.strTinyURLDisplay=[strOfSourceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        objWebViewDisplayData.strTinyURLDisplay=[strOfTinyURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    NSDictionary *dicNotification=[[NSDictionary alloc]initWithObjectsAndKeys:objWebViewDisplayData,@"ContentDic", nil];
    
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationThoughtLeadershipSelection" object:nil userInfo:dicNotification];
    }
    
    
    
}
#pragma mark - Notification Handler
-(void)onClickDownloadBtn:(NSNotification*)notification
{
    
    NSString *strTag=[notification.userInfo valueForKey:@"btnTag"];
    NSString *urlStr=[[arrDataSourcePDF objectAtIndex:[strTag intValue]]valueForKey:@"LocationPath"];
    XMLDownload *objXMLDownload=[[XMLDownload alloc]init];
    NSMutableDictionary *xmlStoringData=[[NSMutableDictionary alloc]init];
    [xmlStoringData setValue:urlStr forKey:@"SourcePath"];
    [xmlStoringData setValue:@"YES" forKey:@"isDownloads"];
    if([strIdentifier isEqualToString:@"Whitepapers"]||[strIdentifier isEqualToString:WhitePapers])
    {
        [xmlStoringData setValue:@"download/WhitePapers" forKey:@"TargetPath"];
    }
    else if([strIdentifier isEqualToString:@"CaseStudies"]||[strIdentifier isEqualToString:CaseStudies])
    {
        [xmlStoringData setValue:@"download/CaseStudies" forKey:@"TargetPath"];
    }
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection])
    {
        AppDelegate *appDelegate=APP_INSTANCE;
        [appDelegate displayActivityIndicator:self.view];
        [appDelegate.spinner startAnimating];
        [objXMLDownload downloadXML:xmlStoringData];
    }
    
    
    
}
-(void)onCompleteDownload:(NSNotification*)notification
{
    
}

-(void)setTableViewFrames
{
    otlTableViewPDF.rowHeight=104;
    otlTableViewPDF.scrollEnabled=YES;
    otlTableViewPDF.contentInset = UIEdgeInsetsMake(0,0,100,0);
    otlTableViewPDF.frame=CGRectMake(10, 0, self.view.frame.size.width-20,[arrDataSourcePDF count]*104);
    
    
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
