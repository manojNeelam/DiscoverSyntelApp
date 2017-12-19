//
//  ThoughtLeadershipControllerIphone.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/21/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ThoughtLeadershipControllerIphone.h"
#import "VideosGridViewControlleriPhone.h"
#import "WebViewDisplayLinksIphone.h"

@interface ThoughtLeadershipControllerIphone ()

@end

@implementation ThoughtLeadershipControllerIphone
@synthesize  objDownloadViewControlleriPhoneViewController, objWhitePapersNCaseStudiesIphoneViewController;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSelectingTLOption:) name:@"NotificationThoughtLeadershipSelection" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSuccessfulDownload:) name:@"NotificationDownloadSuccessful" object:nil];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100.0, 0.0, 50, 44)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    label.textAlignment=NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    [label setText:@"Thought Leadership"];
    self.navigationItem.titleView = label;
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:11],NSFontAttributeName, nil];
    [otlSegmentThoughtLeadershipIphone setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    [self loadDefaultView];
//    
    if(![self fetchDocumentDirectoryFiles])
    {
        [otlSegmentThoughtLeadershipIphone setEnabled:NO forSegmentAtIndex:3];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)segmentControlSelection:(id)sender
{
    if(![self fetchDocumentDirectoryFiles])
    {
        [otlSegmentThoughtLeadershipIphone setEnabled:NO forSegmentAtIndex:3];
    }

    if(otlViewThoughtLeadershipIphone.subviews.count>0)
    {
        [[otlViewThoughtLeadershipIphone.subviews objectAtIndex:0]removeFromSuperview];
    }
    if(otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==2)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        
        objVideosViewController = (VideosGridViewControlleriPhone*)[mainStoryboard
                                                                  instantiateViewControllerWithIdentifier: @"VideosGridViewControlleriPhone"];
     
            
        [otlViewThoughtLeadershipIphone addSubview:objVideosViewController.view];
        

    }

    if(otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==0||otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==1)
    {
        if(otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==0)
        {
            strSelected=WhitePapers;
            
        }
        else if (otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==1)
        {
            strSelected=CaseStudies;
        }
        
//        if([strSelected isEqualToString:WhitePapers])
//        {
//            strSelected=@"Whitepapers";
//        }
//        else if ([strSelected isEqualToString:CaseStudies])
//        {
//            strSelected=@"CaseStudies";
//        }


        self.objWhitePapersNCaseStudiesIphoneViewController.strIdentifier=strSelected;
        NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
        [objUserDefault setValue:strSelected forKey:@"SelectedValue"];
        [self.objWhitePapersNCaseStudiesIphoneViewController setDictionaryValues];
        [self.objWhitePapersNCaseStudiesIphoneViewController.otlTableViewPDF reloadData];
        [otlViewThoughtLeadershipIphone addSubview:self.objWhitePapersNCaseStudiesIphoneViewController.view];
        
    }

    else if (otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==3)
    {
        
        if([self fetchDocumentDirectoryFiles]){
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
            self.objDownloadViewControlleriPhoneViewController=(DownloadViewControlleriPhoneViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DownloadViewiPhone"];
            UITableView* subviewTbl=[self.objDownloadViewControlleriPhoneViewController.view.subviews objectAtIndex:0];
            otlViewThoughtLeadershipIphone.frame=CGRectMake(0,44, subviewTbl.frame.size.width, subviewTbl.frame.size.height);
            
            [otlViewThoughtLeadershipIphone addSubview:self.objDownloadViewControlleriPhoneViewController.view];
        }
        else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"No download available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
       
    }

}
-(BOOL)fetchDocumentDirectoryFiles
{
    BOOL isFileFound=NO;
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

-(void)loadDefaultView
{
    NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
    [objUserDefault setValue:WhitePapers forKey:@"SelectedValue"];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    
    self.objWhitePapersNCaseStudiesIphoneViewController = (WhitePapersNCaseStudiesIphoneViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WhitePapersNCaseStudiesIphone"];
    
    UITableView* subviewTbl=[self.objWhitePapersNCaseStudiesIphoneViewController.view.subviews objectAtIndex:0];
    subviewTbl.frame = CGRectMake(10,0, otlViewThoughtLeadershipIphone.frame.size.width, otlViewThoughtLeadershipIphone.frame.size.height+90);
   // otlViewThoughtLeadershipIphone.frame=CGRectMake(0, 100, subviewTbl.frame.size.width, subviewTbl.frame.size.height);
    
    
    self.objWhitePapersNCaseStudiesIphoneViewController.strIdentifier=WhitePapers;
    [otlViewThoughtLeadershipIphone addSubview:self.objWhitePapersNCaseStudiesIphoneViewController.view];
}

#pragma mark - Notification Handler
-(void)onSelectingTLOption:(NSNotification*)notification
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    
    // For displaying WhitePapers and CaseStudies
        WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone= (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
        objWebViewDisplayLinksIphone.webViewDisplayDataReceived=[notification.userInfo valueForKey:@"ContentDic"];
        [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
        
        
    
}
-(void)onSuccessfulDownload:(NSNotification*)notification
{
    if(otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==0||otlSegmentThoughtLeadershipIphone.selectedSegmentIndex==1)
    {
        [self.objWhitePapersNCaseStudiesIphoneViewController viewWillAppear:true];
    }
    
    
    [otlSegmentThoughtLeadershipIphone setEnabled:YES forSegmentAtIndex:3];
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
