//
//  HomeContentViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "HomeContentViewController.h"
#import "ThoughtLeadershipControllerIphone.h"
#import "IndustryOfferingsViewControllerIphone.h"
#import "TechnologyOfferingsViewControllerIphone.h"
#import "JMImageCache.h"
#import "UIImageView+JMImageCache.h"
#import "Common.h"
#import "IndustrySolutionsVC.h"
#import "TechnologyServicesVC.h"

@interface HomeContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_Left_BaseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_Right_BaseView;

@end

@implementation HomeContentViewController
@synthesize otlLblFlip;

//Code changes by amar

@synthesize bannerImage;


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
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.view.frame=CGRectMake(0, 0, screenWidth, screenHeight);
    
    isMenuSelected=NO;
    
    // Do any additional setup after loading the view.
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *date = app.xmlDate;
    if(date && date != nil)
    {
        date = [date stringByReplacingOccurrencesOfString:@":" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@" " withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }

    
    [self.lblVersion setText:[NSString stringWithFormat:@"Version : %@ #%@", shortVersion, date]];
    

    if(IS_IPHONE)
    {
        NSString *urlAsString = nil;
        if(IS_IPHONE4)
        {
            urlAsString =[NSString stringWithFormat:IPHONE4_URL];
        }
        else if(IS_IPHONE5)
        {
            urlAsString =[NSString stringWithFormat:IPHONE5_URL];
        }
        else if(IS_IPHONE6 || IS_IPHONE6PLUS)
        {
            urlAsString =[NSString stringWithFormat:IPHONE6URL];
        }
        
        [[JMImageCache sharedCache] removeImageForURL:[NSURL URLWithString:urlAsString]]; // Removing exsisting image from cache
        
        //fetch image by url
        [self.bannerImage setImageWithURL:[NSURL URLWithString:urlAsString] placeholder:[UIImage imageNamed:@"BannerIphone"] completionBlock:^(UIImage *img) {
            if(img)
            {
                [self.bannerImage setImage:img];
            }
            
        } failureBlock:^(NSURLRequest *request, NSURLResponse *response, NSError *error) {
            
            if(error)
            {
                
            }
            
        }];
        
        
        
        
      /*
        
        else if(iOSScreenSize.height == 736)
        {
            NSString *img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone_2X.png"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *img1 = [[UIImage alloc]initWithData:data];
            //self.imgTest.image = img1;
            self.bannerImage.image =img1;
            

        }
        else if(iOSScreenSize.height == 750)
        {
            NSString *img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone_2X.png"];
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *img1 = [[UIImage alloc]initWithData:data];
            //self.imgTest.image = img1;
            self.bannerImage.image =img1;
            
            
        }

    */
        
        
    }
    
    
    
    
    
    
    /*
    

 CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
 NSString *img;
 
 if(iOSScreenSize.height == 480)
 {
 img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone.png"];
 
 //self.imgTest.image = img1;
 
 }
 else if(iOSScreenSize.height ==568)
 {
 img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone_2X.png"];
 
 //self.imgTest.image = img1;
 
 }
 else if(iOSScreenSize.height == 667)
 {
 img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDig
 
 
 
 
  
 else if(iOSScreenSize.height == 667)
 {
 img =[NSString stringWithFormat:@"https://marcom.syntel.in/Notification/devicecontent/bannerimages/GoDigitalBanneriPhone_2X.png"];
 
 //self.imgTest.image = img1;
 
 }
 
 NSURL *url = [NSURL URLWithString:img];
 NSData *data = [[NSData alloc] initWithContentsOfURL:url];
 
 if (data != nil) {
 UIImage *img1 = [[UIImage alloc]initWithData:data];
 
 if (img1 != nil) {
 
 self.bannerImage.image =img1;
 }
 }
 
 
 
 
       
       */
 

    
    
    
    
    
    
    
    
    
    
    //Amar changes on 22
    
    
    
    
    
    
    
    
    
    
    
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    isMenuSelected=NO;
    
    [self.view layoutIfNeeded];

   
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    isMenuSelected=NO;
    
    [self.view layoutIfNeeded];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
	if (parent)
		NSLog(@"willMoveToParentViewController");
	else
		NSLog(@"willRemoveFromParentViewController");
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];
    
	if (parent)
		NSLog(@"didMoveToParentViewController");
	else
		NSLog(@"didRemoveFromParentViewController");
}
-(void)animateLabel
{
    otlLblFlip.hidden=NO;
    //otlLblFlip.center = CGPointMake(158, 500);
    
    [UIView animateWithDuration:2.0f
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         //otlLblFlip.center = CGPointMake(158, 450);
     }
                     completion:nil];
}
-(IBAction)onClickHomeMenuOptions:(UIButton*)sender
{
    if(!isMenuSelected){
   if(sender.tag==0){
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
       ThoughtLeadershipControllerIphone *objThoughtLeadershipControllerIphone = (ThoughtLeadershipControllerIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ThoughtLeadershipControllerIphone"];
      [self.navigationController pushViewController:objThoughtLeadershipControllerIphone animated:YES];
   }
        //Manoj kUMAR Dec 13 2016
   else if (sender.tag==1){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
       TechnologyServicesVC *objTechnologyOfferingsViewControllerIphone = (TechnologyServicesVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"TechnologyServicesVC"];
       [self.navigationController pushViewController:objTechnologyOfferingsViewControllerIphone animated:YES];
   }
        //Manoj Kumar Dec 13 2016
   else if (sender.tag==2){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
       IndustrySolutionsVC *objIndustryOfferingsViewControllerIphone = (IndustrySolutionsVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"IndustrySolutionsVC"];
       [self.navigationController pushViewController:objIndustryOfferingsViewControllerIphone animated:YES];
   }
        isMenuSelected=YES;
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
