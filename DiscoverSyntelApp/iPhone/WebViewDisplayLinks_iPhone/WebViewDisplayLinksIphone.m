//
//  WebViewDisplayLinksIphone.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "WebViewDisplayLinksIphone.h"
#import "ActivitySharingViewController.h"


@interface WebViewDisplayLinksIphone ()

@end

@implementation WebViewDisplayLinksIphone
@synthesize webViewDisplayDataReceived;
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
    self.navigationController.navigationBarHidden=NO;
  //  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rotateParent:) name:@"NotificationRotation" object:nil];
    //self.title=webViewDisplayDataReceived.strPageTitle;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 0.0, 50, 44)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    label.textAlignment=NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    [label setText:webViewDisplayDataReceived.strPageTitle];
    self.navigationItem.titleView = label;
    if([webViewDisplayDataReceived.strPageTitle isEqualToString:@"News"])
    {
        self.view.backgroundColor=[UIColor colorWithRed:(237.0/255.0) green:(237.0/255.0) blue:(237.0/255.0) alpha:1.0];
        
    }

    
    otlWebViewDisplayData.scalesPageToFit=YES;
    [self loadWebView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    if([webViewDisplayDataReceived.strPageTitle isEqualToString:@"News"])
    {
        self.view.backgroundColor=[UIColor colorWithRed:(237.0/255.0) green:(237.0/255.0) blue:(237.0/255.0) alpha:1.0];
        
    }

    objFavouritesController=[[FavouritesController alloc]init];
    if([objFavouritesController fetchFavouritesOnLoadForURL:webViewDisplayDataReceived.strURLDisplay sourceURL:webViewDisplayDataReceived.strTinyURLDisplay]){
        // If it is already marked as favourite
        imageRemoveFromFavourite=[UIImage imageNamed:@"RemoveFavoriteIphone.png"];
        [otlBtnFavourites setBackgroundImage:imageRemoveFromFavourite forState:UIControlStateNormal];
        
    }
    else{
        // If it is not marked as favourite
        imageAddToFavourite=[UIImage imageNamed:@"AddToFavoriteIphone.png"];
        [otlBtnFavourites setBackgroundImage:imageAddToFavourite forState:UIControlStateNormal];
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidLayoutSubviews
{
     [super viewDidLayoutSubviews];
}

#pragma mark - UIWebview
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    otlBtnBack.hidden=YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
    NSString *padding = @"document.body.style.padding='0px 30px 20px 20px';";
    [webView stringByEvaluatingJavaScriptFromString:padding];
    NSArray *arrOfTitles=@[News,WhitePapers,CaseStudies,Videos];
    
    if(![arrOfTitles containsObject:webViewDisplayDataReceived.strPageTitle])
    {
    float scale = 90000/webView.scrollView.frame.size.width;
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'", scale];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    }
    if(webView.canGoBack == YES){
        otlBtnBack.hidden=NO;
    }

    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
    
    
}

-(void)loadWebView
{
    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    [appDelegate displayActivityIndicator:otlWebViewDisplayData];
     NSURL *url = [NSURL URLWithString:[webViewDisplayDataReceived.strURLDisplay stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [otlWebViewDisplayData loadRequest:requestObj];
   
    //self.automaticallyAdjustsScrollViewInsets = YES;
    objFavouritesController=[[FavouritesController alloc]init];
    if([objFavouritesController fetchFavouritesOnLoadForURL:webViewDisplayDataReceived.strURLDisplay sourceURL:webViewDisplayDataReceived.strTinyURLDisplay]){
        // If it is already marked as favourite
        imageRemoveFromFavourite=[UIImage imageNamed:@"RemoveFavoriteIphone.png"];
        [otlBtnFavourites setBackgroundImage:imageRemoveFromFavourite forState:UIControlStateNormal];

    }
    else{
        // If it is not marked as favourite
        imageAddToFavourite=[UIImage imageNamed:@"AddToFavoriteIphone.png"];
        [otlBtnFavourites setBackgroundImage:imageAddToFavourite forState:UIControlStateNormal];

    }
}


#pragma mark - Action Handlers
-(IBAction)onClickBackBtn:(id)sender
{
   [otlWebViewDisplayData goBack];
}
-(IBAction)onClickFavourites:(UIButton*)sender
{
    objFavouritesController=[[FavouritesController alloc]init];
    if([[sender backgroundImageForState:UIControlStateNormal ]isEqual:imageAddToFavourite]){
        imageRemoveFromFavourite=[UIImage imageNamed:@"RemoveFavoriteIphone.png"];
        [otlBtnFavourites setBackgroundImage:imageRemoveFromFavourite forState:UIControlStateNormal];
        [objFavouritesController saveFavouritesForURL:webViewDisplayDataReceived];
    }
    else if ([[sender backgroundImageForState:UIControlStateNormal ]isEqual:imageRemoveFromFavourite]){
        if([objFavouritesController deleteFavouritesForURL:webViewDisplayDataReceived.strURLDisplay sourceURL:webViewDisplayDataReceived.strTinyURLDisplay]){
        
        imageAddToFavourite=[UIImage imageNamed:@"AddToFavoriteIphone.png"];
        [otlBtnFavourites setBackgroundImage:imageAddToFavourite forState:UIControlStateNormal];
       
        }
    }
 
}
-(IBAction)onClickShare:(UIButton*)sender
{
    NSString *strTitleShared;
    if([webViewDisplayDataReceived.strPageTitle isEqualToString:WhitePapers]||[webViewDisplayDataReceived.strPageTitle isEqualToString:CaseStudies]||[webViewDisplayDataReceived.strPageTitle isEqualToString:Videos]||[webViewDisplayDataReceived.strPageTitle isEqualToString:News]){
        strTitleShared=webViewDisplayDataReceived.strTitleDisplay;
    }
    else{
        strTitleShared=webViewDisplayDataReceived.strPageTitle;
    }
    NSArray *activityItems = [[NSArray alloc]initWithObjects:strTitleShared,webViewDisplayDataReceived.strTinyURLDisplay,nil];
    
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems applicationActivities:nil];
    activityController.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard];
    
    [self presentViewController:activityController animated:YES completion:^() {
        [activityController setCompletionHandler:^(NSString *activityType, BOOL completed) {
            // Completed
            [UIViewController attemptRotationToDeviceOrientation];
        }];
    }];
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if([webViewDisplayDataReceived.strPageTitle isEqualToString:Videos]){
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
    }
    else{
        //return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
        return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown|UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
    }
    
}

- (NSUInteger)supportedInterfaceOrientations
{
    if([webViewDisplayDataReceived.strPageTitle isEqualToString:Videos]){
    return UIInterfaceOrientationMaskAll;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
       //return UIInterfaceOrientationMaskAll;
    }
}

//-(void)rotateParent:(NSNotification *)notification
//{
//    CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI);
//    self.view.transform = transform;
//    NSLog(@"Parent rotate ");
//}
@end
