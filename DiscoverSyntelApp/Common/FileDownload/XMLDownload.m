//
//  XMLDownload.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/17/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "XMLDownload.h"
#import "AFNetworking.h"
#import  "XMLParserController.h"
#import "XMLParserGData.h"
#import "AppDelegate_Common.h"
@implementation XMLDownload
@synthesize contentModel=_contentModel, contentModelSecondXML=_contentModelSecondXML;

-(void)downloadXML:(NSDictionary*)urlDict
{
    sourcePathStr= [[NSString alloc]init];
    targetPathStr = [[NSString alloc]init];
    sourcePathStr = [urlDict valueForKey:@"SourcePath"];
    targetPathStr = [urlDict valueForKey:@"TargetPath"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
  //NSURL* URL = [NSURL URLWithString:sourcePathStr];
    NSURL *URL = [NSURL URLWithString:[sourcePathStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentDir=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSURL *documentsDirectoryURL;
     
        //integrated
        if ([[urlDict valueForKey:@"isXML"]isEqualToString:@"YES"]) {
          
            documentsDirectoryURL=[[documentDir URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
            NSError* error =nil;
            NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
            NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
          
            NSString *documentPath = [tmpDir path];
            NSString* filePath =[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/WebContent2.xml",targetPathStr]];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (fileExists) {
                [[NSFileManager defaultManager] removeItemAtPath: filePath error: &error];
            }
           
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/WebContent2.xml",targetPathStr]];
        }
        else if ([[urlDict valueForKey:@"isDownloadsVideo"]isEqualToString:@"YES"])
        {
            documentsDirectoryURL=[[documentDir URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
            NSError* error =nil;
            NSURL* URLToFileName = [NSURL URLWithString:[sourcePathStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         
            NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
            NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
            NSString *documentPath = [tmpDir path];

            
            NSString* filePath =[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",targetPathStr,[URLToFileName lastPathComponent]]];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (fileExists) {
                [[NSFileManager defaultManager] removeItemAtPath: filePath error: &error];
            }
           
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",targetPathStr,[URLToFileName lastPathComponent]]];
        }

        else if ([[urlDict valueForKey:@"isDownloads"]isEqualToString:@"YES"])
        {
            documentsDirectoryURL=[[documentDir URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
            NSError* error =nil;
            NSURL* URLToFileName = [NSURL URLWithString:[sourcePathStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
            NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
            NSString *documentPath = [tmpDir path];

            NSString* filePath =[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",targetPathStr,[URLToFileName lastPathComponent]]];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (fileExists) {
                [[NSFileManager defaultManager] removeItemAtPath: filePath error: &error];
            }
           
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",targetPathStr,[URLToFileName lastPathComponent]]];
        }
        else
        {
          //  documentsDirectoryURL=[[documentDir URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"tmp" isDirectory:YES];
            documentsDirectoryURL=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
            NSError* error =nil;
            NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
         //   NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"tmp" isDirectory:YES];
            NSString *documentPath = [documentDirURL path];

            NSString* filePath =[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Webcontent/%@",targetPathStr]];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (fileExists) {
                [[NSFileManager defaultManager] removeItemAtPath: filePath error: &error];
            }
            
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Webcontent/%@",targetPathStr]];
        }
        
    //integrated
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
      
        
        NSString* filePathString = [filePath absoluteString];
        [filePathString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        filePathString= [filePathString stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
         NSArray* nameArr = [sourcePathStr componentsSeparatedByString:@"/"];
        NSString* storedNameStr =[nameArr lastObject];
       
       
        if (error) {
            NSUInteger indexOfTheObject;
            AppDelegate *appDelegate=APP_INSTANCE;
            [appDelegate.spinner stopAnimating];
            [appDelegate.activityView removeFromSuperview];
            NSMutableDictionary* alertDict = [[NSMutableDictionary alloc]init];
            [alertDict setValue:sourcePathStr forKey:@"SourcePath"];
            [alertDict setValue:targetPathStr forKey:@"TargetPath"];
            if ([[urlDict valueForKey:@"isDownloadsVideo"]isEqualToString:@"YES"]){
                indexOfTheObject = [appDelegate.videosDownloadTrackingArray indexOfObject: storedNameStr];
                [appDelegate.videosDownloadTrackingArray removeObjectAtIndex:indexOfTheObject];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotifyDownloadFailureAlert" object:nil userInfo:alertDict];
            }
            if ([[urlDict valueForKey:@"isDownloads"]isEqualToString:@"YES"]){
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Download Failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                NSLog(@"error downloading %@",error);
            
            }
  
        }
        //successfull download
        else
        {
            if ([[urlDict valueForKey:@"isXML"]isEqualToString:@"YES"])
            {
                self.contentModel = [XMLParserGData loadContent:@"firstXML"];
                self.contentModelSecondXML = [XMLParserGData loadContent:@"secondXML"];
                [XMLParserGData saveContent:_contentModel :_contentModelSecondXML];
                
             
               // AppDelegate *appDelegate=APP_INSTANCE;
                AppDelegate_Common *appDelegate=(AppDelegate_Common*)[[UIApplication sharedApplication]delegate];
                // do not backup for xml
                [appDelegate addSkipBackupAttributeToItemAtURL:filePath];
              

                
                
            }
            else if ([[urlDict valueForKey:@"isDownloadsVideo"]isEqualToString:@"YES"])
            {
                NSUInteger indexOfTheObject;
               
                AppDelegate_Common *appDelegate=(AppDelegate_Common*)[[UIApplication sharedApplication]delegate];
                indexOfTheObject = [appDelegate.videosDownloadTrackingArray indexOfObject: storedNameStr];
                [appDelegate.videosDownloadTrackingArray removeObjectAtIndex:indexOfTheObject];
                [appDelegate.spinner stopAnimating];
                [appDelegate.activityView removeFromSuperview];
                // do not back up for video downloaded
                [appDelegate addSkipBackupAttributeToItemAtURL:filePath];

                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Download successful." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationDownloadSuccessful" object:nil userInfo:nil];
               ;
            }
            else if ([[urlDict valueForKey:@"isDownloads"]isEqualToString:@"YES"])
            {
              
          
             AppDelegate_Common *appDelegate=(AppDelegate_Common*)[[UIApplication sharedApplication]delegate];
                [appDelegate.spinner stopAnimating];
                [appDelegate.activityView removeFromSuperview];
                
               
                // do not back up for pdf downloaded
                [appDelegate addSkipBackupAttributeToItemAtURL:filePath];

                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Discover Syntel" message:@"Download successful." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NotificationDownloadSuccessful" object:nil userInfo:nil];
               
                
            }
            //integrated
            if ([[urlDict valueForKey:@"downloadHTML"]isEqualToString:@"YES"]) {
               // AppDelegate *appDelegate=APP_INSTANCE;
                AppDelegate_Common *appDelegate=(AppDelegate_Common*)[[UIApplication sharedApplication]delegate];
                
                // do not back up for html downloaded
                [appDelegate addSkipBackupAttributeToItemAtURL:filePath];
                
                

            }
            
          
            //integrated
            //NotificationDownloadSuccessful
      
        }
    }];
    [downloadTask resume];
    
}

-(void)docDirectoryInteraction:(NSString*)strUrl
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *folderPathString;
    
    if ([strUrl rangeOfString:@"xml"].location != NSNotFound){
        folderPathString=[documentPath stringByAppendingPathComponent:@"xml"];
    }
    else
    {
        folderPathString=[documentPath stringByAppendingPathComponent:@"Download"];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPathString]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPathString withIntermediateDirectories:YES attributes:nil error:nil];
    }
       
    
}
#pragma mark - UIAlertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
       // call file download method
        
    }
}

@end
