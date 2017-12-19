//
//  HomeViewControllerIphone.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/14/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "HomeViewControllerIphone.h"
#import "SyntelContentController.h"
#import "NewsViewController.h"
#import "ContactUsViewControlleriPhone.h"
#import "WhatsNewViewControllerIphone.h"

#define CONTENT_IDENTIFIER @"HomeContentViewController"
#define MIN_SWIPE 1

@interface HomeViewControllerIphone ()

@property (assign, nonatomic) int previousIndex;
@property (assign, nonatomic) int tentativeIndex;
@property (assign, nonatomic) BOOL observerAdded;

@end

@implementation HomeViewControllerIphone
@synthesize previousIndex = _previousIndex;
@synthesize tentativeIndex = _tentativeIndex;
@synthesize flipViewController=_flipViewController;
@synthesize flipView;

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

    
     self.previousIndex = MIN_SWIPE;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onHomeMenuOptionSelection:) name:@"NotificationHomeMenu" object:nil];
    
    [self addingFlipAnimation];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//new flip animation implementation
- (void)addObserver
{
	if (![self observerAdded])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flipViewControllerDidFinishAnimatingNotification:) name:MPFlipViewControllerDidFinishAnimatingNotification object:nil];
		[self setObserverAdded:YES];
	}
}

- (void)removeObserver
{
	if ([self observerAdded])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self name:MPFlipViewControllerDidFinishAnimatingNotification object:nil];
		[self setObserverAdded:NO];
	}
}

- (UIViewController *)contentViewWithIndex:(int)index
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
	HomeContentViewController *objHomeContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeContentViewController"];
    objHomeContentViewController.otlLblFlip.hidden=YES;
    ContentViewController* objContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
   
   objContentViewController.pageIdentifier=@"HomeViewController";
  
    if(index==1)
    {
        objHomeContentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        return objHomeContentViewController;
    }
    
    objContentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
   
    return objContentViewController;
   
}


#pragma mark - MPFlipViewControllerDelegate protocol

- (void)flipViewController:(MPFlipViewController *)flipViewController didFinishAnimating:(BOOL)finished previousViewController:(UIViewController *)previousViewController transitionCompleted:(BOOL)completed
{
	if (completed)
	{
		self.previousIndex = self.tentativeIndex;
	}
}

- (MPFlipViewControllerOrientation)flipViewController:(MPFlipViewController *)flipViewController orientationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		return UIInterfaceOrientationIsPortrait(orientation)? MPFlipViewControllerOrientationVertical : MPFlipViewControllerOrientationHorizontal;
	else
		return MPFlipViewControllerOrientationHorizontal;
}

#pragma mark - MPFlipViewControllerDataSource protocol

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	int index = self.previousIndex;
	index--;
	if (index < 1)
		return nil; // reached beginning, don't wrap
	self.tentativeIndex = index;
	return [self contentViewWithIndex:index];
}

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	int index = self.previousIndex;
	index++;
	if (index > 2)
		return nil; // reached end, don't wrap
	self.tentativeIndex = index;
	return [self contentViewWithIndex:index];
}

#pragma mark - Notifications

- (void)flipViewControllerDidFinishAnimatingNotification:(NSNotification *)notification
{
	NSLog(@"Notification received: %@", notification);
}



-(void)addingFlipAnimation
{
    self.previousIndex = 1;
    //arrOfImages=[self readFromPlist];
	self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:[self flipViewController:nil orientationForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]];
    
	self.flipViewController.delegate = (id)self;
	self.flipViewController.dataSource = (id)self;
    [self.flipView setFrame:CGRectMake(0, 64, self.flipView.frame.size.width, self.flipView.frame.size.height)];
    CGRect pageViewRect = self.flipView.bounds;
    
	//self.flipViewController.view.frame = CGRectMake(self.flipView.frame.origin.x, self.flipView.frame.origin.y, self.flipView.frame.size.width, self.flipView.frame.size.height);
    self.flipViewController.view.frame = pageViewRect;
	[self addChildViewController:self.flipViewController];
	[self.flipView addSubview:self.flipViewController.view];
	[self.flipViewController didMoveToParentViewController:self];
    self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //Calling ContentViewController
    [self.flipViewController setViewController:[self contentViewWithIndex:self.previousIndex] direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
	//Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
	self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
    [self addObserver];
}

#pragma mark - Notification Handler
-(void)onHomeMenuOptionSelection:(NSNotification*)notification
{
    
    NSString *tagValReceived=[notification.userInfo valueForKey:@"btnTagVal"];
    int tagValInt=[tagValReceived intValue];
    
    
    if(tagValInt==6){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        SyntelContentController *objSyntelContentController = (SyntelContentController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SyntelContentController"];
        objSyntelContentController.strWebViewTitle=@"About Us";
        [self.navigationController pushViewController:objSyntelContentController animated:YES];
    }
    else if (tagValInt==7){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
//        SyntelContentController *objSyntelContentController = (SyntelContentController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SyntelContentController"];
        //objSyntelContentController.strWebViewTitle=@"Contact Us";
        ContactUsViewControlleriPhone *contactUsViewControlleriPhone = (ContactUsViewControlleriPhone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ContactUsViewControlleriPhone"];
        
        [self.navigationController pushViewController:contactUsViewControlleriPhone animated:YES];

    }
    else if (tagValInt==5){
        // News
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        NewsViewController *objNewsViewController = (NewsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"NewsViewControllerIphone"];
       [self.navigationController pushViewController:objNewsViewController animated:YES];
    }
    else if (tagValInt==4){
        // Whats New
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        WhatsNewViewControllerIphone *objWhatsNewViewControllerIphone = (WhatsNewViewControllerIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WhatsNewViewControllerIphone"];
        [self.navigationController pushViewController:objWhatsNewViewControllerIphone animated:YES];
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
