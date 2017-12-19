//
//  VideosGridViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "VideosGridViewController.h"
#import "AppDelegate.h"
#import "XMLDownload.h"
#import "WebViewDisplayLinks.h"
#import "DataConnection.h"


@interface VideosGridViewController ()

@end

@implementation VideosGridViewController

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
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onAlertNotification:) name:@"NotifyDownloadFailureAlert" object:nil];
    
    //CollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [otlCollectionViewVideo setCollectionViewLayout:flowLayout];
    [otlCollectionViewVideo registerClass:CollectionViewControllerCell.class forCellWithReuseIdentifier:@"CollectionViewControllerCell"];
    
    [otlCollectionViewVideo setAllowsSelection: YES];
    otlCollectionViewVideo.scrollEnabled=YES;
    AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
    arrDataSourceParsedData=appDelegate.arrChangeSetParsedData;
    // arrDataSourceVideos=[[NSMutableArray alloc]init];
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
    
    numOfSections=ceil((float)[arrDataSourceVideos count]/(float)3);;
    otlCollectionViewVideo.contentInset = UIEdgeInsetsMake(0,0,150,0);
    otlCollectionViewVideo.contentSize=CGSizeMake(self.view.frame.size.width-40, numOfSections*237);
    //otlCollectionViewVideo.frame=CGRectMake(20, 0,self.view.frame.size.width-40 , numOfSections*237-64);
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:NO];
    
    //   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onClickdownloadVideo:) name:@"NotificationOnClickDownloadVideo" object:nil];
    
    otlCollectionViewVideo.contentInset = UIEdgeInsetsMake(0,0,170,0);
    otlCollectionViewVideo.contentSize=CGSizeMake(self.view.frame.size.width-40, numOfSections*237);
    //otlCollectionViewVideo.frame=CGRectMake(20, 0,self.view.frame.size.width-40 , numOfSections*237-64);
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onClickdownloadVideo:) name:@"NotificationOnClickDownloadVideo" object:nil];
    otlCollectionViewVideo.contentInset = UIEdgeInsetsMake(0,0,150,0);
    otlCollectionViewVideo.contentSize=CGSizeMake(self.view.frame.size.width-40, numOfSections*237);
    //otlCollectionViewVideo.frame=CGRectMake(20,0,self.view.frame.size.width-40 , numOfSections*237-64);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return numOfSections;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(numOfSections==1)
    {
        numOfItems=(int)[arrDataSourceVideos count];
    }
    else
    {
        if(section==numOfSections-1)
        {
            numOfItems=[arrDataSourceVideos count]-((numOfSections-1)*3);
        }
        else
        {
            numOfItems=3;
        }
        // numOfItems = ((int)[arrDataSourceVideos count]) % 3;
    }
    
    
    return numOfItems;
}

#pragma mark - UIAlertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        XMLDownload * xmlDownload = [[XMLDownload alloc]init];
        [xmlDownload downloadXML:retryDict];
        // call file download method
        
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Dateformatter
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss z"];
    
    NSString *strCellIdentifier=@"CollectionViewControllerCell";
    objCollectionViewControllerCell = (CollectionViewControllerCell*) [collectionView dequeueReusableCellWithReuseIdentifier:strCellIdentifier forIndexPath:indexPath];
    objCollectionViewControllerCell.titleLabel.text=[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"Title"];
    //  NSString *strPubDate=[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"PublishDate"];
    NSDate* dateObj = [[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"PublishDate"];
    NSString* strPubDateToShow = [dateFormatter stringFromDate:dateObj];
    
    NSArray *arrPubDate=[strPubDateToShow componentsSeparatedByString:@" "];
    
    
    objCollectionViewControllerCell.pubDateLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[arrPubDate objectAtIndex:0],[arrPubDate objectAtIndex:1],[arrPubDate objectAtIndex:2],[arrPubDate objectAtIndex:3]];
    objCollectionViewControllerCell.btnDownloadVideo.tag=indexPath.row+3*indexPath.section;
    
    
    //displaying image
    NSString* imageString =[[arrDataSourceVideos objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"image"];
    NSURL*imageURL = [NSURL URLWithString:imageString];
    
    if([imageDataArray count]==[arrDataSourceVideos count]) {
        objCollectionViewControllerCell.imageView.image = [UIImage imageWithData:[imageDataArray objectAtIndex:indexPath.row+3*indexPath.section]];
    }
    [objCollectionViewControllerCell.imageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"DefaultVideoThumbnail.png"]];
    
    return objCollectionViewControllerCell;}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(241, 235);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,3,0);  // top, left, bottom, right
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dicLocationPath=[NSMutableDictionary dictionary];
    
    [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"Source"] forKey:@"URL"];
    [dicLocationPath setValue:Videos forKey:@"PageTitle"];
    [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"Title"] forKey:@"Title"];
    [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"LocationPath"] forKey:@"FilePath"];
    NSString *strTinyUrlVideo;
    NSArray *arrKeys=[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]allKeys];
    
    if([[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"tinyURL"]!=nil)
    {
        
        strTinyUrlVideo=[[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"tinyURL"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if(![arrKeys containsObject:@"tinyURL"]||[strTinyUrlVideo isEqualToString:@""]){
        // strTinyUrlVideo=[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"Source"];
        [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"Source"] forKey:@"tinyURL"];
    }
    else{
        [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"tinyURL"] forKey:@"tinyURL"];
    }
    
    //    if([strTinyUrlVideo isEqualToString:@""])
    //    {
    //         [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"Source"] forKey:@"tinyURL"];
    //    }
    //    else
    //    {
    //        [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"tinyURL"] forKey:@"tinyURL"];
    //    }
    //
    
    
    // [dicLocationPath setValue:[[dateTemparr objectAtIndex:indexPath.row+3*indexPath.section]valueForKey:@"tinyURL"] forKey:@"tinyURL"];
    
    NSDictionary *dicNotification=[[NSDictionary alloc]initWithObjectsAndKeys:dicLocationPath,@"ContentDic", nil];
    
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationVideoSelection" object:nil userInfo:dicNotification];
    }
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationOnClickDownloadVideo" object:nil];
    
    
}

@end
