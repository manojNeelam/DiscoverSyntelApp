//
//  HomeViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/14/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "HomeViewController.h"
#import "DataConnection.h"
#import "VideoDisplayWebViewController.h"
#import "JMImageCache.h"
#import "UIImageView+JMImageCache.h"
#import "Common.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;

@end

@implementation HomeViewController


// changes by amar on MAy 8 th 2015

@synthesize banner_iPad;


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
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSearchLinkSelection:) name:@"NotificationSearchLinkSelection" object:nil];
    isMenuSelected=NO;
    
	// Do any additional setup after loading the view.
  /*  
    UIImage *titleImage = [UIImage imageNamed: @"news.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:titleImage];
    imageView.frame = CGRectMake(70, 0, 40, 40);
    CGRect applicationFrame = CGRectMake(0, 0, 300, 40);
    UIView * navTitleView = [[UIView alloc] initWithFrame:applicationFrame];
    [navTitleView addSubview:imageView];
    self.navigationItem.titleView = navTitleView;
   */
 
    
    /*
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
       // NSString *img =[NSString stringWithFormat:@"https://i1.sndcdn.com/avatars-000098290475-iw9m74-large.jpg"];
        
    
        
        CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if(iOSScreenSize.height == 1004)
        {
            NSString *img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad.png"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            
            if (data != nil) {
                UIImage *img1 = [[UIImage alloc]initWithData:data];
                
                if (img1 != nil) {
                    
                    self.banner_iPad.image =img1;
                }
            }
            
        }
        

        
     */
        
        
      
      //  CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
        
        
      /*
        
        if(iOSScreenSize.height == 768)
        {
            NSString *img = [NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad.png"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *img1 = [[UIImage alloc]initWithData:data];
            //self.imgTest.image = img1;
            self.banner_iPad.image =img1;
            
        }
       
       

    
        if(iOSScreenSize.height ==1536)
        {
            
            NSString *img = [NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad_2X.png"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *img1 = [[UIImage alloc]initWithData:data];
            //self.imgTest.image = img1;
            self.banner_iPad.image =img1;

        }
       
        
       */
        
        
        /*
        
        NSString *img = [NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad.png"];
        NSURL *url = [NSURL URLWithString:img];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *img1 = [[UIImage alloc]initWithData:data];
        //self.imgTest.image = img1;
        self.banner_iPad.image =img1;
        
    
        
        */
        
        
        
        /*
        CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
       
        
        if(iOSScreenSize.height == 1004)
        {
            NSString *img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad.png"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *myImage = [[UIImage alloc] initWithData:data];
            self.banner_iPad.image = myImage;
            
        }

       
        
        
        
        */
        
        
    
    if(IS_IPAD)
    {
        NSString *urlAsString = nil;
        if(IS_IPAD)
        {
            urlAsString =[NSString stringWithFormat:IPADURL];
        }
        
        [[JMImageCache sharedCache] removeImageForURL:[NSURL URLWithString:urlAsString]]; // Removing exsisting image from cache
        
        //fetch image by url
        [self.banner_iPad setImageWithURL:[NSURL URLWithString:urlAsString] placeholder:[UIImage imageNamed:@"Banner"] completionBlock:^(UIImage *img) {
            if(img)
            {
                [self.banner_iPad setImage:img];
            }
            
        } failureBlock:^(NSURLRequest *request, NSURLResponse *response, NSError *error) {
            
            if(error)
            {
                
            }
            
        }];
        
        

        
        
    
    

   // CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;

    
    
    /*
    
    if(iOSScreenSize.height == 736)
    {
        NSString *img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPad.png"];
        NSURL *url = [NSURL URLWithString:img];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *img1 = [[UIImage alloc]initWithData:data];
        //self.imgTest.image = img1;
        self.banner_iPad.image =img1;
        
        
    }

    
    */
    
   
   
    
    
    
    
    
    
            
    
    
    
    
    
    

    
    /*
     
     
     
     CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
     if(iOSScreenSize.height == 480)
     {
     url = [NSURL URLWithString:[dictBannerimgs objectForKey:@"iPhone_1X"]];
     
     }
     if(iOSScreenSize.height == 568)
     {
     url = [NSURL URLWithString:[dictBannerimgs objectForKey:@"iPhone_2X"]];
     }
     if(iOSScreenSize.height == 667)
     {
     url = [NSURL URLWithString:[dictBannerimgs objectForKey:@"iPhone_2X"]];
     
     }
     if(iOSScreenSize.height == 736)
     {
     url = [NSURL URLWithString:[dictBannerimgs objectForKey:@"iPhone_2X"]];
     
     }

     
     
    */
    
    }
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString *date = app.xmlDate;
    if(date && date != nil)
    {
        date = [date stringByReplacingOccurrencesOfString:@":" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@" " withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    [self.lblVersion setText:[NSString stringWithFormat:@"Version : %@ #%@", shortVersion, date]];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    isMenuSelected=NO;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    isMenuSelected=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action Handlers
-(IBAction)onClickIndustryOfferings:(id)sender
{
  
}
-(IBAction)onClickTechnologyOfferings:(id)sender
{
   
}
-(IBAction)onClickMenuButton:(UIButton*)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    if(!isMenuSelected)
    {
    if(sender.tag==0){
        objThoughtLeaderShipViewController = (ThoughtLeaderShipViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ThoughtLeadershipIdentifier"];
        [self.navigationController pushViewController:objThoughtLeaderShipViewController animated:YES];
    }
    else if (sender.tag==1){
        objIndustrialOfferingsViewController = (IndustrySolutionsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"IndustrySolutionsViewController"];
        [self.navigationController pushViewController:objIndustrialOfferingsViewController animated:YES];
    }
    else if (sender.tag==2){
        objTechnologyOfferingsViewController = (TechnologyServicesViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"TechnologyServicesViewController"];
        [self.navigationController pushViewController:objTechnologyOfferingsViewController animated:YES];
    }
    else if (sender.tag==3){
        objWebViewController = (WebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewControllerSyntelContent"];
        objWebViewController.strWebViewTitle=@"About Us";
        [self.navigationController pushViewController:objWebViewController animated:YES];
    }
    else if (sender.tag==4)
    {
        objNewsListViewController = (NewsListViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"NewsListViewControllerIdentifier"];
        [self.navigationController pushViewController:objNewsListViewController animated:YES];
    }
    else if (sender.tag==5)
    {
        objWhatsNewViewController = (WhatsNewViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WhatsNewControllerIdentifier"];
        [self.navigationController pushViewController:objWhatsNewViewController animated:YES];
    }
      //  ContactUsViewControlleriPad
    else if (sender.tag==6)
    {
        contactUsiPadViewController = (ContactUsiPadViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ContactUsViewControlleriPad"];
       // objWebViewController.strWebViewTitle=@"Contact Us";
        [self.navigationController pushViewController:contactUsiPadViewController animated:YES];
    }
        isMenuSelected=YES;
    }
    
}


-(void)onSearchLinkSelection:(NSNotification*)notification
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    if([[[notification.userInfo valueForKey:@"ContentDic"] valueForKey:@"PageTitle"]isEqualToString:@"Videos"])
    {
                
       VideoDisplayWebViewController *objVideoDisplay=(VideoDisplayWebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"VideoDisplayWebViewController"];
        objVideoDisplay.dicOfContentLoaded=[notification.userInfo valueForKey:@"ContentDic"];
        [self.navigationController pushViewController:objVideoDisplay animated:YES];
    }
    else{
    
    objWebViewDisplayLinks = (WebViewDisplayLinks*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinks"];
    
    objWebViewDisplayLinks.dicOfContentLoaded=[notification.userInfo valueForKey:@"ContentDic"];
    [self.navigationController pushViewController:objWebViewDisplayLinks animated:YES];
    }
}

#pragma mark - UIInterfaceOrientation
-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}


@end
