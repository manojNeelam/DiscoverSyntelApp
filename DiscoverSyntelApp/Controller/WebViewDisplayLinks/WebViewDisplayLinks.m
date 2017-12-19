//
//  WebViewDisplayLinks.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/26/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WebViewDisplayLinks.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface WebViewDisplayLinks ()

@end

@implementation WebViewDisplayLinks
@synthesize strUrlIndustryOfferings,strWebViewTitle,dicOfContentLoaded,strUrlWebViewDisplay,imageAddToFavourite,imageRemoveFromFavourite;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(webViewReload:) name:@"NotificationReloadWebView" object:nil];
    
    if([self.dicOfContentLoaded valueForKey:@"PageTitle"]!=nil){
        self.title=[self.dicOfContentLoaded valueForKey:@"PageTitle"] ;
    }
    if([self.title isEqualToString:@"News"])
    {
        otlWebViewIndustryOfferings.frame=CGRectMake(0, 0, otlWebViewIndustryOfferings.frame.size.width, otlWebViewIndustryOfferings.frame.size.height);
        otlWebViewIndustryOfferings.scalesPageToFit=YES;
        self.view.backgroundColor=[UIColor colorWithRed:(237.0/255.0) green:(237.0/255.0) blue:(237.0/255.0) alpha:1.0];
        
    }
    
     AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate displayActivityIndicator:self.view];
    strUrlIndustryOfferings=[self.dicOfContentLoaded valueForKey:@"URL"];
    NSString *filePath = [strUrlIndustryOfferings stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    //NSURL *url = [NSURL URLWithString:filePath];
    NSURL *url;
    if([self checkStringExsist:filePath])
    {
        url = [NSURL URLWithString:filePath];
    }
    else
    {
        url = [[NSURL alloc] initFileURLWithPath:filePath];
    }
        
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
   // otlWebViewIndustryOfferings.scalesPageToFit=YES;
    [otlWebViewIndustryOfferings loadRequest:requestObj];
    self.automaticallyAdjustsScrollViewInsets = NO;
    otlBtnBack.hidden=YES;
    [self fetchFavouritesOnLoad];
}


-(BOOL)checkStringExsist:(NSString *)str_url
{
    NSRange range = [str_url rangeOfString:@"https:"];
    
    if (range.location == NSNotFound) {
        
        return NO;
    }
    else {
        return YES;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self fetchFavouritesOnLoad];

    if([self.title isEqualToString:@"News"])
    {
        otlWebViewIndustryOfferings.frame=CGRectMake(0, 0, otlWebViewIndustryOfferings.frame.size.width, otlWebViewIndustryOfferings.frame.size.height);
        otlWebViewIndustryOfferings.scalesPageToFit=YES;
        self.view.backgroundColor=[UIColor colorWithRed:(237.0/255.0) green:(237.0/255.0) blue:(237.0/255.0) alpha:1.0];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    UIApplication* application = [UIApplication sharedApplication];
    if (application.statusBarOrientation != UIInterfaceOrientationPortrait)
    {
        UIViewController *temp = [[UIViewController alloc]init];
        [temp.view setBackgroundColor:[UIColor clearColor]];
        [self.navigationController presentViewController:temp animated:NO completion:^{
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }];
    }

    [self fetchFavouritesOnLoad];

    if([self.title isEqualToString:@"News"])
    {
        otlWebViewIndustryOfferings.frame=CGRectMake(0, 0, otlWebViewIndustryOfferings.frame.size.width, otlWebViewIndustryOfferings.frame.size.height);
        otlWebViewIndustryOfferings.scalesPageToFit=YES;
        self.view.backgroundColor=[UIColor colorWithRed:(237.0/255.0) green:(237.0/255.0) blue:(237.0/255.0) alpha:1.0];
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    otlBtnBack.hidden=YES;
	otlBtnForward.enabled = NO;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
    NSString *padding = @"document.body.style.padding='0px 30px 20px 20px';";
    [webView stringByEvaluatingJavaScriptFromString:padding];
    [webView canGoBack];
    if([strIdentifierWebContent isEqualToString:@"PDF"])
    {
        otlBtnBack.hidden=YES;
    }
    else if([strIdentifierWebContent isEqualToString:@"HTML"])
    {
        NSURL *webUrl=webView.request.URL;
        NSString *strWebUrl=[webUrl absoluteString];
        if(countReload==0||[strWebUrl rangeOfString:@"000_Main"].location!=NSNotFound){
        otlBtnBack.hidden=YES;
        countReload++;
        }
        else
        {
            if(webView.canGoBack == YES){
                otlBtnBack.hidden=NO;
            }
            if(webView.canGoForward == YES){
                otlBtnForward.enabled = YES;
            }
        }
        
    }
    else
    {
        if(webView.canGoBack == YES){
            otlBtnBack.hidden=NO;
        }
        if(webView.canGoForward == YES){
            otlBtnForward.enabled = YES;
        }
    }
   
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
    
//    UIAlertView* noConnectionAlert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"No resource found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [noConnectionAlert show];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

#pragma mark - Event Handlers
-(IBAction)onClickBack:(id)sender
{
    [otlWebViewIndustryOfferings goBack];
    
}
-(IBAction)onClickForward:(id)sender
{
    [otlWebViewIndustryOfferings goForward];
}

-(IBAction)onClickShare:(id)sender
{
    NSString *strTinyUrlShare;
    if([dicOfContentLoaded valueForKey:@"tinyURL"]==nil||[[[dicOfContentLoaded valueForKey:@"tinyURL"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""])
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
    activityController.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard];
    
    
    UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityController];
    [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
   // [self presentViewController:activityController
              //         animated:YES completion:nil];
    
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
    
    
    if([self.strUrlIndustryOfferings rangeOfString:TechnologyOfferingsFolder].location!= NSNotFound)
    {
        // For Technical Offerings
        [favListObj setValue:TechnicalOfferings forKey:@"favouriteType"];
        [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteFilePath"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"PageTitle"] forKey:@"favouriteTitle"];
        [favListObj setValue:@"nil" forKey:@"favouritePubDate"];
        [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"tinyURL"] forKey:@"favouriteTinyUrl"];
        
    }
    else if ([self.strUrlIndustryOfferings rangeOfString:IndustryOfferingsFolder].location!= NSNotFound)
    {
        [favListObj setValue:IndustrialOfferings forKey:@"favouriteType"];
        [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteFilePath"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"PageTitle"] forKey:@"favouriteTitle"];
        [favListObj setValue:@"nil" forKey:@"favouritePubDate"];
        [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"tinyURL"] forKey:@"favouriteTinyUrl"];
    }
        else{
        // For White Papers/ Case studies/ News
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"PageTitle"] forKey:@"favouriteType"];
        [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteFilePath"];
        [favListObj setValue:[dicOfContentLoaded valueForKey:@"Title"] forKey:@"favouriteTitle"];
        [favListObj setValue:[dicOfContentLoaded valueForKey:@"PublishDate"] forKey:@"favouritePubDate"];
         // changes
            
       // [favListObj setValue:self.strUrlIndustryOfferings forKey:@"favouriteLink"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"tinyURL"] forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:[self.dicOfContentLoaded valueForKey:@"tinyURL"] forKey:@"favouriteTinyUrl"];
        
    }
    
    
    
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
/*
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
 */
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


-(void)webViewReload:(NSNotification*)notification{
    countReload++;
    
    self.dicOfContentLoaded=[notification.userInfo valueForKey:@"ContentDic"];
    if([self.dicOfContentLoaded valueForKey:@"PageTitle"]!=nil){
        self.title=[self.dicOfContentLoaded valueForKey:@"PageTitle"] ;
    }
    
    if([[self.dicOfContentLoaded valueForKey:@"PageTitle"] isEqualToString:WhitePapers]||[[self.dicOfContentLoaded valueForKey:@"PageTitle"] isEqualToString:CaseStudies]||[[self.dicOfContentLoaded valueForKey:@"PageTitle"] isEqualToString:News])
    {
        strIdentifierWebContent=@"PDF";
    }
    else
    {
        strIdentifierWebContent=@"HTML";
        if([[self.dicOfContentLoaded valueForKey:@"URL"] rangeOfString:@"Main"].location!=NSNotFound)
        {
            countReload=0;
        }
        else
        {
            countReload++;
        }
    }
    
    if([self.title isEqualToString:@"News"])
    {
        otlWebViewIndustryOfferings.frame=CGRectMake(0, 0, otlWebViewIndustryOfferings.frame.size.width, otlWebViewIndustryOfferings.frame.size.height);
        self.view.backgroundColor=[UIColor colorWithRed:(237.0/255.0) green:(237.0/255.0) blue:(237.0/255.0) alpha:1.0];
        
    }

    AppDelegate *appDelegate=APP_INSTANCE;
    [appDelegate displayActivityIndicator:self.view];
    strUrlIndustryOfferings=[self.dicOfContentLoaded valueForKey:@"URL"];
    NSString *filePath = [strUrlIndustryOfferings stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:filePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    otlWebViewIndustryOfferings.scalesPageToFit=YES;
    [otlWebViewIndustryOfferings loadRequest:requestObj];
    self.automaticallyAdjustsScrollViewInsets = NO;
    otlBtnBack.hidden=YES;
    [self fetchFavouritesOnLoad];

    
}


@end
