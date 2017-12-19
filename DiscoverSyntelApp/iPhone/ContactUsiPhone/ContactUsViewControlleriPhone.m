//
//  ContactUsViewControlleriPhone.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ContactUsViewControlleriPhone.h"
#import "SyntelContentController.h"

@interface ContactUsViewControlleriPhone ()

@end

@implementation ContactUsViewControlleriPhone
@synthesize syntelContentController,contactUsMapViewController;
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
    [self loadInitialView];
    self.title=@"Contact us";
    // Do any additional setup after loading the view.
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
-(IBAction)segmentControlSelectionContactUs:(id)sender
{
    if(mapViewNContactView.subviews.count>0)
    {
        [[mapViewNContactView.subviews objectAtIndex:0]removeFromSuperview];
    }
    
    if(segmentControl.selectedSegmentIndex==0)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        syntelContentController = (SyntelContentController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SyntelContentController"];
        syntelContentController.strWebViewTitle=@"Contact Us";
        [syntelContentController.view setFrame:CGRectMake(0, 0, mapViewNContactView.frame.size.width, mapViewNContactView.frame.size.height)];
        [mapViewNContactView addSubview:syntelContentController.view];
    }
    
   else if(segmentControl.selectedSegmentIndex==1)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        
        contactUsMapViewController = (ContactUsMapViewController*)[mainStoryboard
                                                                  instantiateViewControllerWithIdentifier: @"ContactUsMapVCiPhone"];
        [mapViewNContactView addSubview:contactUsMapViewController.view];
    }
}

-(void)loadInitialView
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    syntelContentController = (SyntelContentController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SyntelContentController"];
    syntelContentController.strWebViewTitle=@"Contact Us";
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
      [syntelContentController.view setFrame:CGRectMake(0, 0, mapViewNContactView.frame.size.width, mapViewNContactView.frame.size.height)];
    }
    if(result.height == 568)
    {
      [syntelContentController.view setFrame:CGRectMake(0, 0, mapViewNContactView.frame.size.width, mapViewNContactView.frame.size.height+80)];    }
    
    [mapViewNContactView addSubview:syntelContentController.view];
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
