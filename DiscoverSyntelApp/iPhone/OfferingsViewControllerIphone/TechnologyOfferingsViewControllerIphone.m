//
//  TechnologyOfferingsViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "TechnologyOfferingsViewControllerIphone.h"
#import "WebViewDisplayLinksIphone.h"
#import "WebViewDisplayData.h"
#import "ContentViewController.h"

@interface TechnologyOfferingsViewControllerIphone ()
@property (assign, nonatomic) int previousIndex;
@property (assign, nonatomic) int tentativeIndex;
@property (assign, nonatomic) BOOL observerAdded;
@end

@implementation TechnologyOfferingsViewControllerIphone
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
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320-250, 44)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    label.textAlignment=NSTextAlignmentCenter;
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    [label setText:@"Technology Services"];
    self.navigationItem.titleView = label;
    arrTechnicalOfferingsMenu=[[NSArray alloc]initWithObjects:@"Application Lifecycle",@"BI & Analytics",@"Cloud",@"Digital One",@"Enterprise Solutions",@"IT Infrastructure Management",@"Mobility Solutions",@"Testing", nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onClickTechnicalOfferingsMenuOption:) name:@"NotificationTechnicalOfferingMenu" object:nil];
    [self addingFlipAnimation];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action Handler

-(NSDictionary*)fetchOfferingsSourceUrl
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DiscoverSyntelDataModel" ofType:@"plist"];
    NSMutableDictionary *dicUrl = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return dicUrl;
}
-(NSString*)fetchOfferingsDirectory:(int)index
{
    
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSError * error;
    
    NSString *directoryHtml=[NSString stringWithFormat:@"%@%@",[[documentDirURL path] stringByAppendingString:@"/Webcontent/HTML/"],TechnologyOfferingsFolder];
    NSArray *directoryContents =  [[NSFileManager defaultManager]
                                   contentsOfDirectoryAtPath:directoryHtml error:&error];
    if(directoryContents.count>0)
    {
        return [directoryContents objectAtIndex:index];
    }
    return nil;
    
}
-(NSString*)fetchFilePath:(NSString*)directoryName
{
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
   
    
    NSError * error;
    NSString *directoryHtml=[NSString stringWithFormat:@"%@%@",[[documentDirURL path] stringByAppendingString:@"/Webcontent/HTML/"],[TechnologyOfferingsFolder stringByAppendingPathComponent:directoryName]];
    NSArray *directoryContents =  [[NSFileManager defaultManager]
                                   contentsOfDirectoryAtPath:directoryHtml error:&error];
    NSString *strfilePath;
    for (id file in directoryContents) {
        NSString *filesHtml=[NSString stringWithFormat:@"%@%@%@",directoryHtml,@"/",file];
        if([filesHtml rangeOfString:@"Main.html"].location == NSNotFound){
            // file not found
            strfilePath=nil;
        }
        else{
            strfilePath=filesHtml;
            break;
        }
    }
    
    return strfilePath;
}


//flip animation implementation
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

- (ContentViewController *)contentViewWithIndex:(int)index
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
	
    ContentViewController* objContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    
    objContentViewController.pageIndex = index;
    objContentViewController.pageIdentifier = @"TechnologyOfferings";
    
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
    CGRect pageViewRect = self.flipView.bounds;
	self.flipViewController.view.frame = pageViewRect;
	[self addChildViewController:self.flipViewController];
	[self.flipView addSubview:self.flipViewController.view];
	[self.flipViewController didMoveToParentViewController:self];
    //Calling ContentViewController
    [self.flipViewController setViewController:[self contentViewWithIndex:self.previousIndex] direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
	//Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
	self.view.gestureRecognizers = self.flipViewController.gestureRecognizers;
    [self addObserver];
}


#pragma mark - Notification Handler
-(void)onClickTechnicalOfferingsMenuOption:(NSNotification*)notification
{
    NSString *tagValReceived=[notification.userInfo valueForKey:@"btnTagVal"];
    int tagValInt=[tagValReceived intValue];
    // Fetching Page Title
    NSString *strPageTitleVal=[arrTechnicalOfferingsMenu objectAtIndex:tagValInt];
    
    // Fetching Source URL
    NSDictionary *dicSourceURL=[self fetchOfferingsSourceUrl];
    NSString *strSourceURLVal=[[dicSourceURL valueForKey:@"TechnologyOfferingsUrl"]objectAtIndex:tagValInt];
    
    // Fetching URL file path
    NSString *strOfferingsDirectoryPath=[self fetchOfferingsDirectory:tagValInt];
    NSString *strOfferingsFilePath;
    if(strOfferingsDirectoryPath!=nil){
        strOfferingsFilePath=[self fetchFilePath:strOfferingsDirectoryPath];
    }
    // Fetching Tiny URL
    NSString *strTinyURLVal=strSourceURLVal;
    
    WebViewDisplayData *objWebDisplayData=[[WebViewDisplayData alloc]init];
    objWebDisplayData.strPageTitle=strPageTitleVal;
    objWebDisplayData.strSourceURL=strSourceURLVal;
    objWebDisplayData.strTinyURLDisplay=strTinyURLVal;
    objWebDisplayData.strURLDisplay=strOfferingsFilePath;
    objWebDisplayData.strFilePath=strOfferingsFilePath;
    objWebDisplayData.strTitleDisplay=strPageTitleVal;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebDisplayData;
    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];

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
    return UIInterfaceOrientationMaskPortrait;
}

@end
