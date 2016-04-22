//
//  VideoDisplayWebViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "VideoDisplayWebViewController.h"

@interface VideoDisplayWebViewController ()

@end

@implementation VideoDisplayWebViewController
@synthesize dicOfContentLoaded,strUrlIndustryOfferings,imageAddToFavourite,imageRemoveFromFavourite,strVideoType;
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webViewPauseVideos:) name:@"NotificationPauseVideo" object:nil];
    if([self.dicOfContentLoaded valueForKey:@"PageTitle"]!=nil){
        self.title=[self.dicOfContentLoaded valueForKey:@"PageTitle"] ;
    }
    
   
    strUrlIndustryOfferings=[self.dicOfContentLoaded valueForKey:@"URL"];
    NSString *filePath = [strUrlIndustryOfferings stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
             AppDelegate *appDelegate=APP_INSTANCE;
           [appDelegate displayActivityIndicator:otlWebViewVideo];
           
           NSURL *url = [NSURL URLWithString:filePath];
           NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
           otlWebViewVideo.scalesPageToFit=YES;
           [otlWebViewVideo loadRequest:requestObj];
           self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([[userDefaults valueForKey:@"keyPauseVideo"]isEqualToString:@"strPauseVideo"])
    {
    NSString *filePath = [strUrlIndustryOfferings stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSURL *url = [NSURL URLWithString:filePath];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        otlWebViewVideo.scalesPageToFit=YES;
        [otlWebViewVideo loadRequest:requestObj];
        self.automaticallyAdjustsScrollViewInsets = NO;
        isVideoFormatSupported=YES;
       // [userDefaults setValue:@"strPlayVideo" forKey:@"keyPauseVideo"];
        [self fetchFavouritesOnLoad];
    }
   
    [self fetchFavouritesOnLoad];

   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
  
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
    NSString *padding = @"document.body.style.padding='0px 20px 20px 20px';";
    [webView stringByEvaluatingJavaScriptFromString:padding];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
  


}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
     return YES;
    
}

#pragma mark - Event Handlers
-(IBAction)onClickBack:(id)sender
{
  //  [otlWebViewIndustryOfferings goBack];
}
-(IBAction)onClickForward:(id)sender
{
   // [otlWebViewIndustryOfferings goForward];
}
-(IBAction)onClickShare:(id)sender
{
    NSString *strTinyUrlShare;
    if([dicOfContentLoaded valueForKey:@"tinyURL"]==nil||[[dicOfContentLoaded valueForKey:@"tinyURL"] isEqualToString:@"\n    "])
    {
        strTinyUrlShare=[dicOfContentLoaded valueForKey:@"URL"];
    }
    else
    {
        strTinyUrlShare=[dicOfContentLoaded valueForKey:@"tinyURL"];
    }
    NSArray *activityItems = [[NSArray alloc]initWithObjects:[dicOfContentLoaded valueForKey:@"Title"],strTinyUrlShare,nil];
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController
                       animated:YES completion:nil];
    
}
-(IBAction)onClickFavourite:(UIButton*)sender
{
    //save url,title,pubdate n local file path
    
    if([[sender backgroundImageForState:UIControlStateNormal ]isEqual:imageAddToFavourite]){
        [self saveFavourites];
    }
    else if ([[sender backgroundImageForState:UIControlStateNormal ]isEqual:imageRemoveFromFavourite]){
        [self deleteFavourites];
    }
    
}

-(void)saveFavourites
{
    imageRemoveFromFavourite=[UIImage imageNamed:@"RemoveFavorite.png"];
    [otlBtnFavourites setBackgroundImage:imageRemoveFromFavourite forState:UIControlStateNormal];
    
    AppDelegate *appDelegateObj = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegateObj managedObjectContext];
    NSManagedObject *favListObj = [NSEntityDescription insertNewObjectForEntityForName:@"Favourites" inManagedObjectContext:context];
    
    
           // For Videos
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"PageTitle"] forKey:@"favouriteType"];
        [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteFilePath"];
        [favListObj setValue:[dicOfContentLoaded valueForKey:@"Title"] forKey:@"favouriteTitle"];
        [favListObj setValue:[dicOfContentLoaded valueForKey:@"PublishDate"] forKey:@"favouritePubDate"];
       // [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteLink"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"tinyURL"]  forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"tinyURL"] forKey:@"favouriteTinyUrl"];

    
    
    
    NSError* error = nil;
    [context save:&error];
    
    
}

-(BOOL)deleteFavourites
{
    imageAddToFavourite=[UIImage imageNamed:@"AddToFavorite.png"];
    [otlBtnFavourites setBackgroundImage:imageAddToFavourite forState:UIControlStateNormal];
    
    BOOL result = NO;
    AppDelegate* appDelegateObj = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* managedContextObj = [appDelegateObj managedObjectContext];
    
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedContextObj];
    
    NSFetchRequest* fetchRequestObj = [[NSFetchRequest alloc]init];
    
    [fetchRequestObj setEntity:entityDescription];
   // NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"favouriteLink==%@",self.strUrlIndustryOfferings];
    NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"favouriteLink==%@ OR favouriteLink==%@",self.strUrlIndustryOfferings,[self.dicOfContentLoaded valueForKey:@"tinyURL"]];
    [fetchRequestObj setPredicate:predicateObj];
    NSError* errorObj = nil;
    NSArray* dataFromTable = [managedContextObj executeFetchRequest:fetchRequestObj error:&errorObj];
    if(dataFromTable.count == 0)
    {
        result = NO;
    }
    else
    {
        for(NSManagedObject* tempObj in dataFromTable)
        {
            [managedContextObj deleteObject:tempObj];
        }
        result = [managedContextObj save:&errorObj];
    }
    
    return result;
    
}
-(void)fetchFavouritesOnLoad
{
    AppDelegate* appDelegateObj = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* managedContextObj = [appDelegateObj managedObjectContext];
    
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedContextObj];
    
    NSFetchRequest* fetchRequestObj = [[NSFetchRequest alloc]init];
    
    [fetchRequestObj setEntity:entityDescription];
    NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"favouriteLink==%@ OR favouriteLink==%@",self.strUrlIndustryOfferings,[self.dicOfContentLoaded valueForKey:@"tinyURL"]];
   // NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"favouriteLink==%@",self.strUrlIndustryOfferings];
    [fetchRequestObj setPredicate:predicateObj];
    NSError* errorObj = nil;
    NSArray* arrFavourites = [managedContextObj executeFetchRequest:fetchRequestObj error:&errorObj];
    
    if (arrFavourites.count==0) {
        imageAddToFavourite=[UIImage imageNamed:@"AddToFavorite.png"];
        [otlBtnFavourites setBackgroundImage:imageAddToFavourite forState:UIControlStateNormal];
    }
    else if (arrFavourites.count>0)
    {
        imageRemoveFromFavourite=[UIImage imageNamed:@"RemoveFavorite.png"];
        [otlBtnFavourites setBackgroundImage:imageRemoveFromFavourite forState:UIControlStateNormal];;
    }
    
}
-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
   
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)webViewDownloadForVideos:(NSNotification*)notification
{
    self.dicOfContentLoaded=[notification.userInfo valueForKey:@"ContentDic"];
    if([self.dicOfContentLoaded valueForKey:@"PageTitle"]!=nil){
        self.title=[self.dicOfContentLoaded valueForKey:@"PageTitle"] ;
    }
    
    
    AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate displayActivityIndicator:self.view];
    //[appDelegate.spinner startAnimating];
    strUrlIndustryOfferings=[self.dicOfContentLoaded valueForKey:@"URL"];
    NSString *filePath = [strUrlIndustryOfferings stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:filePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    otlWebViewVideo.scalesPageToFit=YES;
    [otlWebViewVideo loadRequest:requestObj];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self fetchFavouritesOnLoad];

}

-(void)webViewPauseVideos:(NSNotification*)notification
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//    if([[notification.userInfo valueForKey:@"keyType"]isEqualToString:@"Videos"])
//    {
//        [userDefault setValue:@"Videos" forKey:@"keyType"];
//    }
    
    [userDefault setValue:@"strPauseVideo" forKey:@"keyPauseVideo"];
    [otlWebViewVideo loadHTMLString:nil baseURL:nil];
}
#pragma mark - UIAlertview Delegate

@end
