//
//  ThoughtLeaderShipViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ThoughtLeaderShipViewController.h"
#import "DownloadViewController.h"
#import "WebViewDisplayLinks.h"
#import "VideoDisplayWebViewController.h"
#import "DataConnection.h"

@interface ThoughtLeaderShipViewController ()

@end

@implementation ThoughtLeaderShipViewController
@synthesize objWhitePapersCaseStudiesListViewController,objDownloadViewController;
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSelectingVideoOption:) name:@"NotificationVideoSelection" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSuccessfulDownload:) name:@"NotificationDownloadSuccessful" object:nil];
    otlSegmentThoughtLeadership.selectedSegmentIndex=0;
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil];
    [otlSegmentThoughtLeadership setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [self loadInitailView];
    
    if(![self fetchDocumentDirectoryFiles])
    {
        [otlSegmentThoughtLeadership setEnabled:NO forSegmentAtIndex:3];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
   // [otlSegmentThoughtLeadership setTintColor:[UIColor colorWithRed:(0/255.0) green:(143.0/255.0) blue:(161.0/255.0) alpha:1.0]];
    if(![self fetchDocumentDirectoryFiles])
    {
        [otlSegmentThoughtLeadership setEnabled:NO forSegmentAtIndex:3];
    }
   
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
}
- (void)viewDidLayoutSubviews {
    otlViewThoughtLeadership.frame=CGRectMake(0, 100, 768, 914);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SegmentControl
-(IBAction)segmentControlSelection:(id)sender
{
    if(![self fetchDocumentDirectoryFiles])
    {
        [otlSegmentThoughtLeadership setEnabled:NO forSegmentAtIndex:3];
    }

    if(otlViewThoughtLeadership.subviews.count>0)
    {
        [[otlViewThoughtLeadership.subviews objectAtIndex:0]removeFromSuperview];
    }

    if(otlSegmentThoughtLeadership.selectedSegmentIndex==2)
    {
      UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        objVideosGridViewController = (VideosGridViewController*)[mainStoryboard
         instantiateViewControllerWithIdentifier: @"VideosGridViewController"];
        
        UICollectionView* subviewTbl=[objVideosGridViewController.view.subviews objectAtIndex:0];
        otlViewThoughtLeadership.frame=CGRectMake(0, 100, subviewTbl.frame.size.width, subviewTbl.frame.size.height);
        [otlViewThoughtLeadership addSubview:objVideosGridViewController.view];
    }
    if(otlSegmentThoughtLeadership.selectedSegmentIndex==0||otlSegmentThoughtLeadership.selectedSegmentIndex==1)
    {
        if(otlSegmentThoughtLeadership.selectedSegmentIndex==0)
        {
            strSelected=WhitePapers;
        }
        else if (otlSegmentThoughtLeadership.selectedSegmentIndex==1)
        {
            strSelected=CaseStudies;
        }
        NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
        [objUserDefault setValue:strSelected forKey:@"SelectedValue"];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
       self.objWhitePapersCaseStudiesListViewController = (WhitePapersCaseStudiesListViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WhitePapersCaseStudiesListViewController"];
        
        UITableView* subviewTbl=[self.objWhitePapersCaseStudiesListViewController.view.subviews objectAtIndex:0];
        
        otlViewThoughtLeadership.frame=CGRectMake(0, 100, subviewTbl.frame.size.width, subviewTbl.frame.size.height);
        self.objWhitePapersCaseStudiesListViewController.strIdentifier=strSelected;
        
               [otlViewThoughtLeadership addSubview:self.objWhitePapersCaseStudiesListViewController.view];
        
    }
    else if (otlSegmentThoughtLeadership.selectedSegmentIndex==3)
    {
        
        if([self fetchDocumentDirectoryFiles]){
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            self.objDownloadViewController=(DownloadViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DownloadListViewController"];
            UITableView* subviewTbl=[self.objDownloadViewController.view.subviews objectAtIndex:0];
            otlViewThoughtLeadership.frame=CGRectMake(0,100, subviewTbl.frame.size.width, subviewTbl.frame.size.height);
            
            [otlViewThoughtLeadership addSubview:self.objDownloadViewController.view];
        }
        else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"No download available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        

    }

}

#pragma mark - Notification Handler
-(void)onSelectingVideoOption:(NSNotification*)notification
{
    
    
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
       if([[[notification.userInfo valueForKey:@"ContentDic"]valueForKey:@"PageTitle"]isEqualToString:@"Videos"]){
           // For displaying Videos
           VideoDisplayWebViewController *objVideoDisplayWebViewController= (VideoDisplayWebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VideoDisplayWebViewController"];
           objVideoDisplayWebViewController.dicOfContentLoaded=[notification.userInfo valueForKey:@"ContentDic"];
           [self.navigationController pushViewController:objVideoDisplayWebViewController animated:YES];
       }
       else{
           
           // For displaying WhitePapers and CaseStudies
           WebViewDisplayLinks *objWebViewDisplayLinks= (WebViewDisplayLinks*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinks"];
           objWebViewDisplayLinks.dicOfContentLoaded=[notification.userInfo valueForKey:@"ContentDic"];
           [self.navigationController pushViewController:objWebViewDisplayLinks animated:YES];
           
        
       }

}

-(void)loadInitailView
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
    [objUserDefault setValue:WhitePapers forKey:@"SelectedValue"];
    self.objWhitePapersCaseStudiesListViewController = (WhitePapersCaseStudiesListViewController*)[mainStoryboard
                                                                                              instantiateViewControllerWithIdentifier: @"WhitePapersCaseStudiesListViewController"];
    UITableView* subviewTbl=[self.objWhitePapersCaseStudiesListViewController.view.subviews objectAtIndex:0];
    
    otlViewThoughtLeadership.frame=CGRectMake(0, 110, subviewTbl.frame.size.width, subviewTbl.frame.size.height);
    
    
    self.objWhitePapersCaseStudiesListViewController.strIdentifier=WhitePapers;
    [otlViewThoughtLeadership addSubview:self.objWhitePapersCaseStudiesListViewController.view];
    
}
-(BOOL)fetchDocumentDirectoryFiles
{
    BOOL isFileFound=NO;
    
  //  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  //  NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [tmpDir path];

    
    BOOL isCaseStudyFileFound=[self fileCheckWithDocumentDirectoryPath:[documentsDirectory stringByAppendingString:@"/download/CaseStudies"]];
    BOOL isWhitePaperFileFound=[self fileCheckWithDocumentDirectoryPath:[documentsDirectory stringByAppendingString:@"/download/WhitePapers"]];
    BOOL isVideoFound=[self fileCheckWithDocumentDirectoryPath:[documentsDirectory stringByAppendingString:@"/download/Videos"]];
    
    if(!isCaseStudyFileFound && !isWhitePaperFileFound && !isVideoFound){
        isFileFound=NO;
    }
    else{
        isFileFound=YES;
    }
    return isFileFound;
    
}
-(BOOL)fileCheckWithDocumentDirectoryPath:(NSString*)strPath
{
    BOOL isFile=NO;
    NSError *error=nil;
    NSArray *directoryContents=[[NSFileManager defaultManager]
                                           contentsOfDirectoryAtPath:strPath error:&error];
    
    if(directoryContents.count>0){
        isFile=YES;
    }
    return isFile;
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
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

-(void)onSuccessfulDownload:(NSNotification*)notification
{
    [otlSegmentThoughtLeadership setEnabled:YES forSegmentAtIndex:3];
}

@end
