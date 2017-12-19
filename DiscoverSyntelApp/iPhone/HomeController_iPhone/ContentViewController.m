//
//  ContentViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;

@end

@implementation ContentViewController
@synthesize pageIndex, pageIdentifier,otlLblFlip,otlLblPage;

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
    
    isMenuSelected=NO;
    if ([pageIdentifier isEqualToString:@"HomeViewController"]) {
        button1.tag=4;
        button2.tag=5;
        button3.tag=6;
        button4.tag=7;
        [button1 setBackgroundImage:[UIImage imageNamed:@"What'sNewIphone@2x.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"NewsIphone@2x.png"] forState:UIControlStateNormal];
        [button3 setBackgroundImage:[UIImage imageNamed:@"AboutUsIphone@2x.png"] forState:UIControlStateNormal];
        [button4 setBackgroundImage:[UIImage imageNamed:@"ContactUsIphone@2x.png"] forState:UIControlStateNormal];

        
    }
    if ([pageIdentifier isEqualToString:@"TechnologyOfferings"]) {
        if (pageIndex==1) {
            button1.tag=0;
            button2.tag=5;
            button3.tag=3;
            button4.tag=4;
            
            [button1 setBackgroundImage:[UIImage imageNamed:@"ApplicationLifecycleIphone@2x.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"ITInfrastructureManagementIphone@2x.png"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIImage imageNamed:@"DigitalOneIphone@2x.png"] forState:UIControlStateNormal];
            [button4 setBackgroundImage:[UIImage imageNamed:@"EnterpriseSolutionsIphone@2x.png"] forState:UIControlStateNormal];
            otlLblPage.hidden=YES;
            otlLblFlip.hidden=NO;
        
        }
        else if (pageIndex==2) {
            button1.tag=2;
            button2.tag=1;
            button3.tag=6;
            button4.tag=7;
            
            [button1 setBackgroundImage:[UIImage imageNamed:@"CloudIphone@2x.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"BI&AnalyticsIphone@2x.png"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIImage imageNamed:@"MobilitySolutionsIphone@2x.png"] forState:UIControlStateNormal];
            [button4 setBackgroundImage:[UIImage imageNamed:@"TestingIphone@2x.png"] forState:UIControlStateNormal];

            otlLblPage.text=@"Page 2 of 2";
        }

    }
    
    if ([pageIdentifier isEqualToString:@"IndustryOfferings"]) {
        if (pageIndex==1) {
            button1.tag=0;
            button2.tag=1;
            button3.tag=2;
            button4.tag=3;
            
            [button1 setBackgroundImage:[UIImage imageNamed:@"B&FIphone@2x.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"Healthcare&LifeScienceIphone@2x.png"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIImage imageNamed:@"InsuranceIphone@2x.png"] forState:UIControlStateNormal];
            [button4 setBackgroundImage:[UIImage imageNamed:@"LogisticsIphone@2x.png"] forState:UIControlStateNormal];
            otlLblFlip.hidden=NO;
            otlLblPage.hidden=YES;
            
        }
        else if (pageIndex==2) {
            button1.tag=4;
            button2.tag=5;
            button3.tag=6;
            [button4 setHidden:YES];
          
            [button1 setBackgroundImage:[UIImage imageNamed:@"ManufacturingIphone@2x.png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[UIImage imageNamed:@"RetailIphone@2x.png"] forState:UIControlStateNormal];
            [button3 setBackgroundImage:[UIImage imageNamed:@"TelcomIphone@2x.png"] forState:UIControlStateNormal];
            otlLblPage.text=@"Page 2 of 2";
        }
        
    }

       // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    isMenuSelected=NO;
    
    [self.view layoutIfNeeded];

    
  //  [self animateLabel];
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
-(IBAction)onClickBtnOption:(UIButton*)sender
{
    if(!isMenuSelected){
    
    NSMutableDictionary *dicOfferingsNotification=[[NSMutableDictionary alloc]init];
    NSString *strTagValue=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    [dicOfferingsNotification setValue:strTagValue  forKey:@"btnTagVal"];

    if ([pageIdentifier isEqualToString:@"HomeViewController"]) {
        NSLog(@"homeView");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationHomeMenu" object:nil userInfo:dicOfferingsNotification];
        
    }
    
    if ([pageIdentifier isEqualToString:@"TechnologyOfferings"]) {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationTechnicalOfferingMenu" object:nil userInfo:dicOfferingsNotification];
    }
    
    if ([pageIdentifier isEqualToString:@"IndustryOfferings"]) {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationIndustrialOfferingMenu" object:nil userInfo:dicOfferingsNotification];
    }
        isMenuSelected=YES;
    }
}

-(void)animateLabel
{
    UILabel *otlLabel=[[UILabel alloc]init];
    if(otlLblFlip.hidden==YES){
        otlLblPage.hidden=NO;
        otlLabel=otlLblPage;
    }
    else if (otlLblPage.hidden==YES)
    {
        otlLblFlip.hidden=NO;
        otlLabel=otlLblFlip;
    }
    
    
    //otlLabel.center = CGPointMake(158, 500);
    
    [UIView animateWithDuration:2.0f
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         //otlLabel.center = CGPointMake(158, 450);
     }
                     completion:nil];
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
