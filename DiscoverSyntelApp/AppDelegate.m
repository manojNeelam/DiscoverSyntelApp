//
//  AppDelegate.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/10/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFHTTPRequestOperation.h"
#import "AFNetworking.h"
#import "CopyWebContentController.h"
#import "XMLParserController.h"
#import "XMLDownload.h"
#import "DataConnection.h"
#import "HomeViewController.h"
#import "WhatsNewCellController.h"

@implementation AppDelegate
@synthesize videosDownloadTrackingArray, reloadWhatsNew;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.reloadWhatsNew = 0;
    self.videosDownloadTrackingArray = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onSuccessfulResponse:) name:@"ContentAvailable" object:nil];
    

    // 1- Copying the webcontent and xml to document directory
    CopyWebContentController *objCopyWebContentController=[[CopyWebContentController alloc]initWithNibName:@"CopyWebContentController" bundle:nil];
    [objCopyWebContentController copyWebContentToDocumentDirectory];
    
    // 2- Parsing xml
    XMLParserController *objXMLParserController=[[XMLParserController alloc]init];
    [objXMLParserController parseXML];
    
    
    // 3- Check network connectivity
    DataConnection *objData=[[DataConnection alloc]init];
    self.isOnline=[objData networkConnection];
    if(self.isOnline){
        // 3a-Check for new xml, 3b-parse timestamp
        
        //3c- Compare timestamp
        self.isTimestampGreater=YES;
        if(self.isTimestampGreater){

        }
        else{
            // server side content not updated
            self.isContentUpdated=NO;
        }
    }
    else
    {
        // Offline
        self.isContentUpdated=NO;
    }
    
    //NSuser defaults
    NSUserDefaults *objUserDefault = [NSUserDefaults standardUserDefaults];
    strUserDefault=[objUserDefault valueForKey:@"deviceTokenRegistered"];
   if (![strUserDefault isEqualToString:@"Yes"])
    {
        
        
        
        //Changes done by amar for iOS8 device reg for notification
        
        
        
       
      //  [[UIApplication sharedApplication]registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
        
     
        
        
        //New code for iOS8 device reg for notification
        
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        }

        
        
}
    
    //checking for tap on notification from terminated state only
    NSDictionary *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    NSLog(@"notification payload %@", notificationPayload);
    if(notificationPayload) {
    
        [self downloadNewXMLData];
        application.applicationIconBadgeNumber=0;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
     
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
        WhatsNewViewController *controller = (WhatsNewViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WhatsNewControllerIdentifier"];
        
        [navigationController pushViewController:controller animated:YES];
        // figure out what's in the notificationPayload dictionary
    }
    else{
      //checking new xml
        [objXMLParserController checkNewXML:self.xmlDate];
        }
  
////    //testing web service
//    //device token Webservice
//    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
// 
//    
//    NSDictionary *params = @{@"Id":@"0",
//                             @"Token": @"f526960de7d8d3d38f56d19d570929fc3b6eaaa32dcc06879935e216fdfc2ee7",
//                             @"DeviceType": @"iPad",
//                             @"OsVersion":@"7.1",
//                             @"Latitude":@"NotNew",
//                             @"Longitude":@"NotNew"
//                             };
//    
//    
//    ////
//    
//    
//    
//    // manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
//    
//    
//    [manager POST:dmzCheckNewContent parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
//        [objUserDefault setValue:@"Yes" forKey:@"deviceTokenRegistered"];
//        NSLog(@"%@", responseObject);
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        
//        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"device token updated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"%@", error);
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"device token not updated" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    }];
//    
    
//    ///////
   // self.isOrientationChanged=NO;
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc =[storybord instantiateInitialViewController];
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self.spinner stopAnimating];
    [self.activityView removeFromSuperview];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)displayActivityIndicator:(UIView*)view
{
    self.spinner=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   // if(self.isOrientationChanged)
//    if(UIDeviceOrientationIsLandscape(UIInterfaceOrientationLandscapeLeft)||UIDeviceOrientationIsLandscape(UIInterfaceOrientationLandscapeRight))
//    {
//       self.activityView  = [[UIView alloc] initWithFrame:CGRectMake(1024/2-80/2, 768/2-80/2, 80, 80)];
//    }
//    else{
        self.activityView  = [[UIView alloc] initWithFrame:CGRectMake(self.window.frame.size.width/2-80/2, self.window.frame.size.height/2-80/2, 80, 80)];
 //   }
    
   // self.activityView  = [[UIView alloc] initWithFrame:CGRectMake(self.window.frame.size.width/2-80/2, self.window.frame.size.height/2-80/2, 80, 80)];
   
    self.spinner.frame=CGRectMake(20,20,40, 40);
    double cornerRadius=9.0f;
    self.activityView.backgroundColor=[UIColor darkGrayColor];
    [self.activityView addSubview:self.spinner];
    [view addSubview:self.activityView];
    [self.spinner startAnimating];
     CALayer *ptrLayer = [[CALayer alloc] init];
    [ptrLayer setFrame:CGRectMake(0, 0, self.activityView.frame.size.width, self.activityView.frame.size.height)];
    [ptrLayer setCornerRadius:cornerRadius];
    self.activityView.backgroundColor = [UIColor clearColor];
    self.activityView.alpha=0.5;
    self.activityView.center = CGPointMake(view.bounds.size.width / 2.0f, view.bounds.size.height / 2.0f);
    self.activityView.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin);
    UIColor *grey = [UIColor darkGrayColor];
    CGColorRef colorRef = [grey CGColor];
    [ptrLayer setBackgroundColor:colorRef];
    [ptrLayer setBorderColor:[[UIColor clearColor] CGColor]];
    [ptrLayer setOpacity:1.0];
    [ptrLayer setBorderWidth:0.2f];
    [[self.activityView layer] insertSublayer:ptrLayer atIndex:0];
    [[self.activityView layer] setMasksToBounds:YES];
    //self.isOrientationChanged=NO;
}
- (void)saveContext
{
    NSError *error = nil;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            abort();
        }
    }
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FavouritesDataModel" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil)
    {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DiscoverSyntel.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        abort();
    }
    
    // do not backup for sqlite
    [self addSkipBackupAttributeToItemAtURL:storeURL];
    return persistentStoreCoordinator;
}


- (NSURL *)applicationDocumentsDirectory
{
    //  NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    // NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
    // [self addSkipBackupAttributeToItemAtURL:tmpDir];
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
#pragma mark - Skip Backup Attribute
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}



#pragma mark - checking and downloading XML
-(void)onSuccessfulResponse:(NSNotification*)notification
{
    
    //if response succesful  download new xml
    if ([[notification.userInfo valueForKey:@"responseValue"]isEqualToString:@"1"]) {
        [self downloadNewXMLData];
    }
    if(self.isTimestampGreater){
        
    }
    
}
-(void)downloadNewXMLData
{
    //3d- Download xml and replace with existing xml
    NSString* downloadXML = dmzDownloadNewXML;
    XMLDownload *objXMLDownload=[[XMLDownload alloc]init];
    NSMutableDictionary* xmlStoringData = [[NSMutableDictionary alloc]init];
    [xmlStoringData setValue:downloadXML forKey:@"SourcePath"];
    [xmlStoringData setValue:@"xml" forKey:@"TargetPath"];
    [xmlStoringData setValue:@"YES" forKey:@"isXML"];
    [objXMLDownload downloadXML:xmlStoringData];
    self.isContentUpdated=YES;
    
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark - Push Notification Delegates

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"My device token is %@", deviceToken);
    
    //device token Webservice
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSString* newToken = [[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    NSDictionary *params = @{@"Id":@"0",
                             @"Token": newToken,
                             @"DeviceType": @"Apple",
                             @"OsVersion":@"7.1",
                             @"Latitude":@"NotNew",
                             @"Longitude":@"NotNew"
                             };
    
    
    
    // manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // if response JSON format
    
    
    [manager POST:dmzCheckNewContent parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSUserDefaults *objUserDefault=[NSUserDefaults standardUserDefaults];
        [objUserDefault setValue:@"Yes" forKey:@"deviceTokenRegistered"];
        NSLog(@"%@", responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }];
    
    
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"the error is %@",error);
}

-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ( application.applicationState == UIApplicationStateActive)
    {
        [self downloadNewXMLData];
    }
    else{
        [self downloadNewXMLData];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        
        
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        
        
        
        WhatsNewViewController *controller = (WhatsNewViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WhatsNewControllerIdentifier"];
        
        [navigationController pushViewController:controller animated:YES];
        
        
    }
    application.applicationIconBadgeNumber=0;
}





@end
