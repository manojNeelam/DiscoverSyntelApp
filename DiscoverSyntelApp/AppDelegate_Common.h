//
//  AppDelegate_Common.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/16/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate_Common : UIResponder<UIApplicationDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSString* strUserDefault;
}
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSArray *arrChangeSetParsedData;
@property (assign,nonatomic) BOOL isOnline;
@property (assign,nonatomic) BOOL isTimestampGreater;
@property (assign,nonatomic) BOOL isContentUpdated;
@property (strong, nonatomic) NSMutableArray* arrDataSourceChangeSet;
@property(nonatomic, strong) UIView *activityView;
@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic,strong) NSString* xmlDate;
@property(nonatomic,retain) NSMutableArray *videosDownloadTrackingArray;
@property(nonatomic) int reloadWhatsNew;
-(void)displayActivityIndicator:(UIView*)view;
-(void)downloadNewXMLData;
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
@end
