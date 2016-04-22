//
//  WhitePapersCaseStudiesListViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WhitePapersCaseStudiesListViewController.h"
#import "AppDelegate.h"
#import "XMLDownload.h"
#import "DataConnection.h"
@interface WhitePapersCaseStudiesListViewController ()

@end

@implementation WhitePapersCaseStudiesListViewController
@synthesize strIdentifier;
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
    if([strUserDefault isEqualToString:WhitePapers])
    {
        strIdentifier=@"Whitepapers";
    }
    else if ([strUserDefault isEqualToString:CaseStudies])
    {
        strIdentifier=@"CaseStudies";
    }
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedData=appDelegate.arrChangeSetParsedData;
    //arrDataSourcePDF=[[NSMutableArray alloc]init];
    NSMutableArray *arrTemp=[NSMutableArray array];
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:strIdentifier])
        {
            [arrTemp addObject:[objDic valueForKey:strIdentifier]];
        }
    }
    arrDataSourcePDF=[arrTemp objectAtIndex:0];
    [self setTableViewFrame];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self setTableViewFrame];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self setTableViewFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrDataSourcePDF count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"PDFListCellIdentifier";
    objPDFListCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (objPDFListCell == nil)
    {
        objPDFListCell=[[[NSBundle mainBundle]loadNibNamed:@"PDFListCell" owner:self options:nil] objectAtIndex:0];
    }
    objPDFListCell.selectionStyle=UITableViewCellSelectionStyleNone;
    objPDFListCell.backgroundColor=[UIColor clearColor];
    
    //objPDFListCell.otlImageView.image=[[[arrDataSourceNewsobjectAtIndex:indexPath.row]valueForKey:@"Title"]objectAtIndex:0];
    if(arrDataSourcePDF.count>0)
    {
    objPDFListCell.otlBtnDownLoad.tag=indexPath.row;
    objPDFListCell.otlLabel.text=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Description"];
        objPDFListCell.otlLabelTitle.text=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Title"];
    }
   
    
    return objPDFListCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSMutableDictionary *dicLocationPath=[NSMutableDictionary dictionary];
    [dicLocationPath setValue:[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"LocationPath"] forKey:@"URL"];
    [dicLocationPath setValue:[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"LocationPath"] forKey:@"FilePath"];
   
    // setting source url if tiny url is empty
    NSString *strTinyUrlVal=[[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"]==nil||[[[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
       strTinyUrlVal=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Source"];
    }
    else
    {
        strTinyUrlVal=[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"tinyURL"];
    }
   [dicLocationPath setValue:strTinyUrlVal forKey:@"tinyURL"];
    [dicLocationPath setValue:strUserDefault forKey:@"PageTitle"];
    [dicLocationPath setValue:[[arrDataSourcePDF objectAtIndex:indexPath.row]valueForKey:@"Title"] forKey:@"Title"];
    
    NSDictionary *dicNotification=[[NSDictionary alloc]initWithObjectsAndKeys:dicLocationPath,@"ContentDic", nil];

    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection]){
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationVideoSelection" object:nil userInfo:dicNotification];
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
     if([strIdentifier isEqualToString:WhitePapers])
    {
        [xmlStoringData setValue:@"download/WhitePapers" forKey:@"TargetPath"];
    }
    else if([strIdentifier isEqualToString:CaseStudies])
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

-(void)setTableViewFrame
{
    otlTableViewPDF.rowHeight=99;
    otlTableViewPDF.scrollEnabled=YES;
    otlTableViewPDF.contentInset = UIEdgeInsetsMake(0,0,100,0);
    otlTableViewPDF.frame=CGRectMake(20, 0, self.view.frame.size.width-40,[arrDataSourcePDF count]*99-64);
}



@end
