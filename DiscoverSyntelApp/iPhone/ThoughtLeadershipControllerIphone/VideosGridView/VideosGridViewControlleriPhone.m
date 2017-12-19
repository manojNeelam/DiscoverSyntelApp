//
//  VideosGridViewControlleriPhone.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "VideosGridViewControlleriPhone.h"
#import "AppDelegate.h"
#import "DataConnection.h"
#import "XMLDownload.h"
#import "WebViewDisplayData.h"

@interface VideosGridViewControlleriPhone ()

@end

@implementation VideosGridViewControlleriPhone

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationOnClickDownloadVideo" object:nil];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onClickdownloadVideo:) name:@"NotificationOnClickDownloadVideo" object:nil];
    
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedData=appDelegate.arrChangeSetParsedData;
    arrDataSourceVideos=[[NSMutableArray alloc]init];
    NSMutableArray *arrTemp=[NSMutableArray array];
    for (NSDictionary *objDic in arrDataSourceParsedData) {
        if([[[objDic allKeys]objectAtIndex:0] isEqualToString:@"Videos"])
        {
            [arrTemp addObject:[objDic valueForKey:@"Videos"]];
        }
    }
    arrDataSourceVideos=[arrTemp objectAtIndex:0];
    
    //sorting array using date
    NSMutableArray* dateArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary* tDict1 in arrDataSourceVideos)
    {
        NSMutableDictionary *tDict = [NSMutableDictionary dictionaryWithDictionary:tDict1];
        NSString* tempString = [tDict objectForKey:@"PublishDate"];
        NSString* tempDateStr = [[tempString componentsSeparatedByString:@"-"]objectAtIndex:0];
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"EEE, d MMM yyyy"];
        NSDate *date1 = [dateFormat dateFromString:tempDateStr];
        [tDict setObject:date1 forKey:@"PublishDate"];
        [dateArray addObject:tDict];
    }
    
    
    
    dateTemparr = [[NSMutableArray alloc]init];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"PublishDate" ascending:NO selector:@selector(compare:)];
    NSArray *arr = [NSArray arrayWithObject:sortDescriptor];
    dateTemparr = [NSMutableArray arrayWithArray:[dateArray sortedArrayUsingDescriptors:arr]];

    [self setTableViewFrame];
    otlVideoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
      // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self setTableViewFrame];

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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrDataSourceVideos count];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Dateformatter
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss z"];
    

    
    static NSString *CellIdentifier = @"VideosTableCellIdentifier";
    objVideoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (objVideoCell == nil)
    {
        objVideoCell=[[[NSBundle mainBundle]loadNibNamed:@"VideosTableViewCellControllerTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    objVideoCell.otlLblTitle.text = [[dateTemparr objectAtIndex:indexPath.row]valueForKey:@"Title"];
   
    //setting date on dateLabel
   NSDate* dateObj = [[dateTemparr objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
    NSString* strPubDateToShow = [dateFormatter stringFromDate:dateObj];
    NSArray *arrPubDate=[strPubDateToShow componentsSeparatedByString:@" "];
    objVideoCell.otlLblPubDate.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[arrPubDate objectAtIndex:0],[arrPubDate objectAtIndex:1],[arrPubDate objectAtIndex:2],[arrPubDate objectAtIndex:3]];
    objVideoCell.btnDownloadVideo.tag=indexPath.row;
    
       //displaying image
    NSString* imageString =[[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"image"];
    NSURL*imageURL = [NSURL URLWithString:imageString];
    [objVideoCell.otlImageVideo setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"DefaultVideoThumbnailIphone.png"]];
    objVideoCell.selectionStyle=UITableViewCellSelectionStyleNone;
    objVideoCell.backgroundColor=[UIColor clearColor];
    
    
    return objVideoCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebViewDisplayData *objWebViewDisplayData=[[WebViewDisplayData alloc]init];
   // NSString *strOfURL=[[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"LocationPath"];
    NSString *strOfSourceURL=[[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"Source"];
    NSString *strOfTinyURL=[[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"tinyURL"];
    objWebViewDisplayData.strURLDisplay=strOfSourceURL;
    objWebViewDisplayData.strFilePath=strOfSourceURL;
   // objWebViewDisplayData.strURLDisplay= [strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // objWebViewDisplayData.strFilePath=[strOfURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strPageTitle=Videos;
   // objWebViewDisplayData.strSourceURL=[strOfSourceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    objWebViewDisplayData.strSourceURL=strOfSourceURL;
    objWebViewDisplayData.strTitleDisplay=[[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"Title"];
    
    // setting source url if tiny url is empty
    
    if([[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"tinyURL"]==nil||[[[[arrDataSourceVideos objectAtIndex:indexPath.row]valueForKey:@"tinyURL"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
    {
      //  objWebViewDisplayData.strTinyURLDisplay=[strOfSourceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        objWebViewDisplayData.strTinyURLDisplay=strOfSourceURL;
    }
    else
    {
       // objWebViewDisplayData.strTinyURLDisplay=[strOfTinyURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        objWebViewDisplayData.strTinyURLDisplay=strOfTinyURL;
    }
    
    
    NSDictionary *dicNotification=[[NSDictionary alloc]initWithObjectsAndKeys:objWebViewDisplayData,@"ContentDic", nil];
    
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationThoughtLeadershipSelection" object:nil userInfo:dicNotification];
    }
    

    
}
-(void)setTableViewFrame
{
    otlVideoTableView.rowHeight=119;
    otlVideoTableView.scrollEnabled=YES;
    otlVideoTableView.contentInset = UIEdgeInsetsMake(0,0,100,0);
    otlVideoTableView.frame=CGRectMake(10, 0, self.view.frame.size.width-20,[arrDataSourceVideos count]*119-64);
}

#pragma mark - Notification Handler

-(void)onClickdownloadVideo:(NSNotification*)notification
{
    NSString *strTag=[notification.userInfo valueForKey:@"btnTag"];
    NSString *urlStr=[[arrDataSourceVideos objectAtIndex:[strTag intValue]]valueForKey:@"LocationPath"];
    BOOL isVideoFormatSupported=YES;
    if([urlStr rangeOfString:@"mp4"].location==NSNotFound)
    {
        isVideoFormatSupported=NO;
    }
    else
    {
        isVideoFormatSupported=YES;
    }
    
    if(isVideoFormatSupported){
        NSArray* nameArr = [urlStr componentsSeparatedByString:@"/"];
        NSString* storedNameStr =[nameArr lastObject];
        AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
        if ([appDelegate.videosDownloadTrackingArray containsObject:storedNameStr]) {
            
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Download already in progress" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            
            // [appDelegate.videosDownloadTrackingArray addObject:strTag];
            NSString *urlStr=[[arrDataSourceVideos objectAtIndex:[strTag intValue]]valueForKey:@"LocationPath"];
            NSArray* nameArr = [urlStr componentsSeparatedByString:@"/"];
            NSString* storedNameStr =[nameArr lastObject];
            
            XMLDownload *objXMLDownload=[[XMLDownload alloc]init];
            NSMutableDictionary *xmlStoringData=[[NSMutableDictionary alloc]init];
            [xmlStoringData setValue:urlStr forKey:@"SourcePath"];
            [xmlStoringData setValue:@"YES" forKey:@"isDownloadsVideo"];
            [xmlStoringData setValue:@"download/Videos" forKey:@"TargetPath"];
            DataConnection *objDataConnection=[[DataConnection alloc]init];
            if([objDataConnection networkConnection]){
                [appDelegate displayActivityIndicator:self.view];
                [appDelegate.videosDownloadTrackingArray addObject:storedNameStr];
                [objXMLDownload downloadXML:xmlStoringData];
                
            }
            
        }
    }
    else
    {
        UIAlertView* noConnectionAlert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Video format not supported." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [noConnectionAlert show];
        
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
