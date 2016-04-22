//
//  CopyWebContentController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/14/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "CopyWebContentController.h"


@interface CopyWebContentController ()

@end

@implementation CopyWebContentController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)copyWebContentToDocumentDirectory
{
    // Fetching Directory Path from main bundle
    NSString *bundleRoot = [[NSBundle mainBundle] resourcePath];
    
    // Fetching Document Directory Path
    
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    //Library/Caches
    NSURL *cacheDir=[[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
    NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"tmp" isDirectory:YES];
    // do not backup for Documents
  //  [self addSkipBackupAttributeToItemAtURL:documentDirURL];
    
    // do not backup for tmp
    [self addSkipBackupAttributeToItemAtURL:tmpDir];
    
    NSString *documentPathForWebContent=[[documentDirURL path] stringByAppendingPathComponent:@"Webcontent"];
    
    //check if the directory already exist in the document directory
    if (! [[NSFileManager defaultManager] fileExistsAtPath:documentPathForWebContent isDirectory:nil]){
        // Copying Webcontent directory from main bundle
        
        
        [[NSFileManager defaultManager] copyItemAtPath:[bundleRoot stringByAppendingPathComponent:@"Webcontent"] toPath:documentPathForWebContent error:nil];
       
    }
    else{
        
//        [[NSFileManager defaultManager] removeItemAtPath:documentPathForWebContent error:nil];
//        [[NSFileManager defaultManager] copyItemAtPath:[bundleRoot stringByAppendingPathComponent:@"Webcontent"] toPath:documentPathForWebContent error:nil];
        
    }
    
    // do not backup for webcontent
    [self addSkipBackupAttributeToItemAtURL:[documentDirURL URLByAppendingPathComponent:@"Webcontent"]];
    
    [self copyXMLContentToDocumentDirectory:[cacheDir path] mainBundlePath:bundleRoot urlDirectory:cacheDir];
    
    [self copyDownloadToDocumentDirectory:[cacheDir path] mainBundlePath:bundleRoot urlDirectory:cacheDir];
    
   
    
}
-(void)copyXMLContentToDocumentDirectory:(NSString*)documentDirectoryPath mainBundlePath:(NSString *)bundlePath urlDirectory:(NSURL*)url
{
    NSString *documentPathForXML=[documentDirectoryPath stringByAppendingPathComponent:@"xml"];
    
    if (! [[NSFileManager defaultManager] fileExistsAtPath:documentPathForXML isDirectory:nil]){
        // Copying XML directory from main bundle
        [[NSFileManager defaultManager] copyItemAtPath:[bundlePath stringByAppendingPathComponent:@"xml"] toPath:documentPathForXML error:nil];
    }
    // do not backup for xml
    [self addSkipBackupAttributeToItemAtURL:url];
    
}
-(void)copyDownloadToDocumentDirectory:(NSString*)documentDirectoryPath mainBundlePath:(NSString *)bundlePath urlDirectory:(NSURL*)url
{
    
    NSString *documentPathForXML=[documentDirectoryPath stringByAppendingPathComponent:@"download"];
    if (! [[NSFileManager defaultManager] fileExistsAtPath:documentPathForXML isDirectory:nil]){
        // Copying download directory from main bundle
        [[NSFileManager defaultManager] copyItemAtPath:[bundlePath stringByAppendingPathComponent:@"download"] toPath:documentPathForXML error:nil];
    }
    // do not backup for downloads
    [self addSkipBackupAttributeToItemAtURL:url];

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


@end
