//
//  FavouritesController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 5/16/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "FavouritesController.h"

@implementation FavouritesController
-(void)saveFavouritesForURL:(WebViewDisplayData*)obj
{
    AppDelegate_iPhone *appDelegateObj = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegateObj managedObjectContext];
    NSManagedObject *favListObj = [NSEntityDescription insertNewObjectForEntityForName:@"Favourites" inManagedObjectContext:context];
    NSString *strFavLink=obj.strURLDisplay;
    NSString *strFilePath=obj.strFilePath;
    NSString *strTinyURLFav=obj.strTinyURLDisplay;
   // NSString *strFavLink = [obj.strURLDisplay stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  //  NSString *strFilePath = [obj.strFilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSString *strTinyURLFav=[obj.strTinyURLDisplay stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if([obj.strURLDisplay rangeOfString:TechnologyOfferingsFolder].location!= NSNotFound)
    {
        // For Technical Offerings
        [favListObj setValue:TechnicalOfferings forKey:@"favouriteType"];
        [favListObj setValue:strFilePath forKey:@"favouriteFilePath"];
        [favListObj setValue:obj.strTitleDisplay forKey:@"favouriteTitle"];
        [favListObj setValue:@"nil" forKey:@"favouritePubDate"];
        [favListObj setValue:strFavLink forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:strTinyURLFav forKey:@"favouriteTinyUrl"];
        
    }
    else if ([obj.strURLDisplay rangeOfString:IndustryOfferingsFolder].location!= NSNotFound)
    {
        [favListObj setValue:IndustrialOfferings forKey:@"favouriteType"];
        [favListObj setValue:strFilePath forKey:@"favouriteFilePath"];
        [favListObj setValue:obj.strTitleDisplay forKey:@"favouriteTitle"];
        [favListObj setValue:@"nil" forKey:@"favouritePubDate"];
        [favListObj setValue:strFavLink forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:strTinyURLFav forKey:@"favouriteTinyUrl"];    }
    else{
        // For White Papers/ Case studies/ News
        NSString *strSourceURL=obj.strSourceURL;
       
        
        /*if(obj.strURLDisplay==nil||[obj.strURLDisplay isEqualToString:@""]){
         //  strSourceURL=[obj.strSourceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            strSourceURL=obj.strSourceURL;
        }
        
        else{
          //  strSourceURL=[obj.strURLDisplay stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            strSourceURL=obj.strURLDisplay;
            
        
        }
         */
            
        [favListObj setValue:obj.strPageTitle forKey:@"favouriteType"];
        [favListObj setValue:strFilePath forKey:@"favouriteFilePath"];
        [favListObj setValue:obj.strTitleDisplay forKey:@"favouriteTitle"];
        [favListObj setValue:obj.strPubDateDisplay forKey:@"favouritePubDate"];
        [favListObj setValue:strSourceURL forKey:@"favouriteLink"];
        [favListObj setValue:@"nil" forKey:@"favouriteID"];
        [favListObj setValue:strTinyURLFav forKey:@"favouriteTinyUrl"];
        
    }
    
    
    
    NSError* error = nil;
    [context save:&error];

}
-(BOOL)deleteFavouritesForURL:(NSString*)strURL sourceURL:(NSString*)strSourceURL
{
    BOOL result = NO;
    AppDelegate_iPhone* appDelegateObj = APP_INSTANCE_IPHONE;
    
    NSManagedObjectContext* managedContextObj = [appDelegateObj managedObjectContext];
    
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedContextObj];
    
    NSFetchRequest* fetchRequestObj = [[NSFetchRequest alloc]init];
    
    [fetchRequestObj setEntity:entityDescription];
    
    NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"favouriteLink==%@ OR favouriteLink==%@",strURL,strSourceURL];
    [fetchRequestObj setPredicate:predicateObj];
    NSError* errorObj = nil;
    NSArray* dataFromTable = [managedContextObj executeFetchRequest:fetchRequestObj error:&errorObj];
    if(dataFromTable.count == 0)
    {
        result = NO;
    }
    else
    {
        for(NSManagedObject* tempObj in dataFromTable)
        {
            [managedContextObj deleteObject:tempObj];
        }
        result = [managedContextObj save:&errorObj];
    }
    
    return result;

}
-(BOOL)fetchFavouritesOnLoadForURL:(NSString*)strURL sourceURL:(NSString*)strSourceURL
{
    BOOL isFavourite=NO;
    AppDelegate_iPhone* appDelegateObj = APP_INSTANCE_IPHONE;
    
    NSManagedObjectContext* managedContextObj = [appDelegateObj managedObjectContext];
    
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedContextObj];
    NSFetchRequest* fetchRequestObj = [[NSFetchRequest alloc]init];
    [fetchRequestObj setEntity:entityDescription];
    NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"favouriteLink==%@ OR favouriteLink==%@",strURL,strSourceURL];
    
    [fetchRequestObj setPredicate:predicateObj];
    NSError* errorObj = nil;
    NSArray* arrFavourites = [managedContextObj executeFetchRequest:fetchRequestObj error:&errorObj];
    
    if (arrFavourites.count==0){
        isFavourite=NO;
    }
    else if (arrFavourites.count>0){
        isFavourite=YES;
    }
    return isFavourite;
}
@end
