//
//  DownloadViewControlleriPhoneViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "DownloadViewControlleriPhoneViewController.h"
#import "WebViewDisplayData.h"

@interface DownloadViewControlleriPhoneViewController ()

@end

@implementation DownloadViewControlleriPhoneViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onDeleteDownloadFile:) name:@"NotificationDeleteDownloadFile" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSuccessfulDownload:) name:@"NotificationDownloadSuccessful" object:nil];
    
    objTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    objTableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    [self reloadData];
    // Do any additional setup after loading the view.
}

-(void)reloadData
{
    arrDataSourceDownload = [[NSArray alloc]init];
    arrDataSourceDownload=[self fetchDownloadsUrlFromDocDirectory];
    [self setDownloadTableFrame];
    arrDownloadIcon=[[NSArray alloc]initWithObjects:@"PdfSymbol.png",@"VideoSymbol.png",nil];
    [objTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self setDownloadTableFrame];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return [directoryContentsCaseStudies count];
    }
    if (section==1) {
        return [directoryContentsWhitePapers count];
    }
    return [directoryContentsVideos count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DownloadCellIdentifieriPhone";
    objDownloadCellController = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (objDownloadCellController == nil)
    {
        objDownloadCellController=[[[NSBundle mainBundle]loadNibNamed:@"DownloadViewCelliPhone" owner:self options:nil] objectAtIndex:0];
    }
    
    objDownloadCellController.selectionStyle=UITableViewCellSelectionStyleNone;
    
    objDownloadCellController.backgroundColor=[UIColor clearColor];
    
    
    if (indexPath.section==0) {
        // objDownloadCellController.otlLblFileName.text = [directoryContentsCaseStudies objectAtIndex:indexPath.row];
        objDownloadCellController.otlLblFileName.text=[[self fetchXmlForTitles:[directoryContentsCaseStudies objectAtIndex:indexPath.row] withXmlKey:@"CaseStudies"] objectAtIndex:0];
        objDownloadCellController.otlImgDownload.image=[UIImage imageNamed:[arrDownloadIcon objectAtIndex:0]];
        objDownloadCellController.otlBtnDeleteDownload.tag=100+indexPath.row;
    }
    if (indexPath.section==1) {
        // objDownloadCellController.otlLblFileName.text = [directoryContentsWhitePapers objectAtIndex:indexPath.row];
        objDownloadCellController.otlLblFileName.text=[[self fetchXmlForTitles:[directoryContentsWhitePapers objectAtIndex:indexPath.row] withXmlKey:@"Whitepapers"]objectAtIndex:0];
        objDownloadCellController.otlImgDownload.image=[UIImage imageNamed:[arrDownloadIcon objectAtIndex:0]];
        objDownloadCellController.otlBtnDeleteDownload.tag=200+indexPath.row;
    }
    if (indexPath.section==2) {
        // objDownloadCellController.otlLblFileName.text = [directoryContentsVideos objectAtIndex:indexPath.row];
        objDownloadCellController.otlLblFileName.text=[[self fetchXmlForTitles:[directoryContentsVideos objectAtIndex:indexPath.row] withXmlKey:@"Videos"]objectAtIndex:0];
        
        objDownloadCellController.otlImgDownload.image=[UIImage imageNamed:[arrDownloadIcon objectAtIndex:1]];
        objDownloadCellController.otlBtnDeleteDownload.tag=300+indexPath.row;
    }
    
    return objDownloadCellController;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // NSString *strSectionTitle;
    NSString *strFavouriteTitle;
    NSString *strTinyUrl;
    BOOL isVideoFormatSupported=YES;
    WebViewDisplayData *objWebViewDisplayData=[[WebViewDisplayData alloc]init];
    if (indexPath.section==0) {
        
        
        urlLinkString = [NSString stringWithFormat:@"%@/%@",directoryHtmlCaseStudies,[directoryContentsCaseStudies objectAtIndex:indexPath.row]];
        
       
        objWebViewDisplayData.strPageTitle=@"Case Studies";
        
        strFavouriteTitle=[[self fetchXmlForTitles:[directoryContentsCaseStudies objectAtIndex:indexPath.row] withXmlKey:@"CaseStudies"]objectAtIndex:0];
        strTinyUrl=[[self fetchXmlForTitles:[directoryContentsCaseStudies objectAtIndex:indexPath.row] withXmlKey:@"CaseStudies"]objectAtIndex:1];
        
        
        isVideoFormatSupported=YES;
    }
    
    if (indexPath.section==1) {
        urlLinkString = [NSString stringWithFormat:@"%@/%@",directoryHtmlWhitePapers,[directoryContentsWhitePapers objectAtIndex:indexPath.row]];
        
        objWebViewDisplayData.strPageTitle=@"White Papers";
        strFavouriteTitle=[[self fetchXmlForTitles:[directoryContentsWhitePapers objectAtIndex:indexPath.row] withXmlKey:@"Whitepapers"]objectAtIndex:0];
        strTinyUrl=[[self fetchXmlForTitles:[directoryContentsWhitePapers objectAtIndex:indexPath.row] withXmlKey:@"Whitepapers"]objectAtIndex:1];
        isVideoFormatSupported=YES;
    }
    
    if (indexPath.section==2) {
        urlLinkString = [NSString stringWithFormat:@"%@/%@",directoryHtmlVideos,[directoryContentsVideos objectAtIndex:indexPath.row]];
        objWebViewDisplayData.strPageTitle=@"Videos";
        strFavouriteTitle=[[self fetchXmlForTitles:[directoryContentsVideos objectAtIndex:indexPath.row] withXmlKey:@"Videos"]objectAtIndex:0];
        strTinyUrl=[[self fetchXmlForTitles:[directoryContentsVideos objectAtIndex:indexPath.row] withXmlKey:@"Videos"]objectAtIndex:1];
        if([urlLinkString rangeOfString:@"mp4"].location==NSNotFound)
        {
            isVideoFormatSupported=NO;
        }
        else
        {
            isVideoFormatSupported=YES;
        }
        
    }
    /*
    objWebViewDisplayData.strURLDisplay=[urlLinkString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strFilePath=[urlLinkString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strSourceURL=[strTinyUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strTinyURLDisplay=[strTinyUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strTitleDisplay=[strFavouriteTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    */
    objWebViewDisplayData.strURLDisplay=urlLinkString;
    objWebViewDisplayData.strFilePath=urlLinkString;
    objWebViewDisplayData.strSourceURL=strTinyUrl;
    objWebViewDisplayData.strTinyURLDisplay=strTinyUrl;
    objWebViewDisplayData.strTitleDisplay=strFavouriteTitle;
  //  objWebViewDisplayData.strPageTitle=strSectionTitle;
    
    NSDictionary *dicNotification=[[NSDictionary alloc]initWithObjectsAndKeys:objWebViewDisplayData,@"ContentDic", nil];
    
    if(!isVideoFormatSupported)
    {
        UIAlertView* noConnectionAlert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Video format not supported." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [noConnectionAlert show];
    }
    else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationThoughtLeadershipSelection" object:nil userInfo:dicNotification];
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0 && directoryContentsCaseStudies.count>0)
    {
        return 26;
    }
    else if (section==1 && directoryContentsWhitePapers.count>0)
    {
        return 26;
    }
    else if (section==2 && directoryContentsVideos.count>0)
    {
        return 26;
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 26)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 16)];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.textColor=[UIColor darkGrayColor];
    
    UILabel *labelSep = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, tableView.frame.size.width+20, 1)];
    labelSep.backgroundColor=[UIColor darkGrayColor];
    labelSep.text = @"";
    [view addSubview:labelSep];
    
    if(section==0 && directoryContentsCaseStudies.count>0)
    {
        label.text=@"Case Studies";;
        [view addSubview:label];
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
    }
    else if (section==1 && directoryContentsWhitePapers.count>0)
    {
        label.text=@"White Papers";;
        [view addSubview:label];
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
    }
    else if (section==2 && directoryContentsVideos.count>0)
    {
        
        label.text=@"Videos";
        [view addSubview:label];
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
    }
    
    
    
    
    return nil;
}


-(NSArray *)fetchDownloadsUrlFromDocDirectory
{
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
    
    
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [tmpDir path];
    NSError * error;
    
    directoryHtmlCaseStudies=[documentsDirectory stringByAppendingString:@"/download/CaseStudies"];
    directoryHtmlWhitePapers=[documentsDirectory stringByAppendingString:@"/download/WhitePapers"];
    directoryHtmlVideos=[documentsDirectory stringByAppendingString:@"/download/Videos"];
    
    directoryContentsCaseStudies=[[NSFileManager defaultManager]
                                  contentsOfDirectoryAtPath:directoryHtmlCaseStudies error:&error];
    directoryContentsWhitePapers=[[NSFileManager defaultManager]
                                  contentsOfDirectoryAtPath:directoryHtmlWhitePapers error:&error];
    directoryContentsVideos=[[NSFileManager defaultManager]
                             contentsOfDirectoryAtPath:directoryHtmlVideos error:&error];
    if(directoryContentsCaseStudies.count>0)
    {
        return directoryContentsCaseStudies;
    }
    
    if (directoryContentsWhitePapers.count>0) {
        return directoryContentsWhitePapers;
    }
    if (directoryContentsVideos.count>0) {
        
    }
    
    return nil;
    
}

-(void)onDeleteDownloadFile:(NSNotification*)notification
{
    int tagVal=(int)[[[notification.userInfo valueForKey:@"Notification"]valueForKey:@"DeleteBtnTag"]integerValue];
    if(tagVal>99 && tagVal<200){
        strFilePath = [NSString stringWithFormat:@"%@/%@",directoryHtmlCaseStudies,[directoryContentsCaseStudies objectAtIndex:tagVal-100]];
    }
    else if(tagVal>199 && tagVal<300){
        strFilePath=[NSString stringWithFormat:@"%@/%@",directoryHtmlWhitePapers,[directoryContentsWhitePapers objectAtIndex:tagVal-200]];
    }
    else if(tagVal>299 && tagVal<400){
        strFilePath=[NSString stringWithFormat:@"%@/%@",directoryHtmlVideos,[directoryContentsVideos objectAtIndex:tagVal-300]];
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Do you want to delete this file?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    
    
    
}
-(void)setDownloadTableFrame
{
    NSInteger height = [directoryContentsWhitePapers count]+[directoryContentsCaseStudies count]+[directoryContentsVideos count];
    //  [objTableView setFrame:CGRectMake(20, 0, self.view.frame.size.width,height*44)];
    objTableView.contentSize =CGSizeMake(self.view.frame.size.width,height*44);
    // [objTableView setFrame:CGRectMake(20, 0, self.view.frame.size.width,height*44)];
    objTableView.scrollEnabled=YES;
    objTableView.rowHeight=52;
    objTableView.contentInset = UIEdgeInsetsMake(0, 0,200, 0);
    objTableView.sectionHeaderHeight=26;
    objTableView.sectionFooterHeight=0.0;
    objTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(NSArray*)fetchXmlForTitles:(NSString *)strFileName withXmlKey:(NSString*)strKey
{
    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    NSArray *arrXmlResponse=appDelegate.arrChangeSetParsedData;
    NSMutableArray *arrXmlTitle=[NSMutableArray array];
    for (id xmlObj in arrXmlResponse) {
        if([xmlObj valueForKey:strKey]!=nil){
            arrXmlTitle=[xmlObj valueForKey:strKey];
            break;
        }
    }
    
    NSString *strTitleForFileName=[self fetchTitleWithArray:arrXmlTitle andFileName:strFileName];
    NSArray *arrOfString=[strTitleForFileName componentsSeparatedByString:@"----"];
    return arrOfString;
    
}

-(NSString *)fetchTitleWithArray:(NSMutableArray*)arrXml andFileName:(NSString *)fileName
{
    NSString *strTitleFileName;
    NSString *strTinyUrl;
    for (id obj in arrXml) {
        NSString *strLocationPath=[obj valueForKey:@"LocationPath"];
        if([strLocationPath rangeOfString:fileName].location != NSNotFound){
            strTitleFileName=[obj valueForKey:@"Title"];
            if([obj valueForKey:@"tinyURL"]==nil ||[[[obj valueForKey:@"tinyURL"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""]){
                strTinyUrl=[obj valueForKey:@"Source"];
            }
            else{
                strTinyUrl=[obj valueForKey:@"tinyURL"];}
            return [NSString stringWithFormat:@"%@----%@",strTitleFileName,strTinyUrl];
        }
    }
    return [NSString stringWithFormat:@"%@----%@",strTitleFileName,strTinyUrl];
}
#pragma mark - UIAlertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        [self removeFileFromDocumentDirectory];
        
    }
}
-(void)removeFileFromDocumentDirectory
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isFileDeleted=NO;
    if([fileManager removeItemAtPath:strFilePath error:nil]){
        isFileDeleted=YES;
    }
    arrDataSourceDownload=[self fetchDownloadsUrlFromDocDirectory];
    
    [self setDownloadTableFrame];
    [objTableView reloadData];
    NSString *alertMsg;
    if(isFileDeleted){
        alertMsg=@"File deleted successfully.";
    }
    else{
        alertMsg=@"File could not be deleted.";
    }
    
    [self reloadData];
    
    UIAlertView *alertDeletion=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:alertMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alertDeletion show];
    
}

#pragma mark - Notification Handler

-(void)onSuccessfulDownload:(NSNotification*)notification
{
    arrDataSourceDownload=[self fetchDownloadsUrlFromDocDirectory];
    [objTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
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
