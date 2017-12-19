//
//  XMLParserController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "XMLParserController.h"
#import "AppDelegate.h"
#import "XMLDownload.h"
#import "AFNetworking.h"

@implementation XMLParserController
@synthesize elementString=_elementString;

-(void)parseXML
{
    //  data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"WebContent" ofType:@"xml"]];
    
    // Fetch xml from document directory
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
    NSString *documentPathForXML=[[tmpDir path] stringByAppendingPathComponent:@"xml"];

    
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   // NSString *documentPathForXML=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"xml"];
    if([[NSFileManager defaultManager] fileExistsAtPath:documentPathForXML])
    {
        data=[[NSFileManager defaultManager]contentsAtPath:[documentPathForXML stringByAppendingPathComponent:@"WebContent.xml"]];
    }
    xmlParser = [[NSXMLParser alloc]initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
    
}
-(void)checkNewXML:(NSString*)dateString
{
    
   
    NSLog(@"dateString %@",dateString);
    NSString* string =[NSString stringWithFormat:@"%@?deviceLastModifiedDate=%@",dmzCheckNewContent,dateString];
    NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
 
    // Make sure to set the responseSerializer correctly
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"value received%@",str);
        NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
        [dict setValue:str forKey:@"responseValue"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ContentAvailable" object:nil userInfo:dict];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Discovering Syntel App"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        
        
    }];
    
    [operation start];
    
    
}

#pragma mark - XML Parser Delegates

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"error %@",parseError);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary *)attributeDict{
    parserDelegateTrackCount=0;
    self.elementString = elementName;
    NSLog(@"Element started %@",elementName);
    if ([elementName isEqualToString:@"Content"]) {
        
        parentDictArray = [[NSMutableArray alloc]init];
        
        
    }
    
    if ([elementName isEqualToString:@"News"]||[elementName isEqualToString:@"Videos"]||[elementName isEqualToString:@"CaseStudies"]||[elementName isEqualToString:@"Whitepapers"]||[elementName isEqualToString:@"ChangeSet"]||[elementName isEqualToString:@"WhatsNew"]) {
        parentDict = [[NSMutableDictionary alloc]init];
        itemDictArray = [[NSMutableArray alloc]init];
    }
    if ([elementName isEqualToString:@"Item"]) {
        itemDict = [[NSMutableDictionary alloc]init];
    }
    
    
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if(newString.length >0)
    {
        if(!elementString)
        {
            elementString = [[NSMutableString alloc] init];
            
            [elementString appendString:string];
        }
        else
        {
            [elementString appendString:string];
        }
    }
    
    
    if (parserDelegateTrackCount==0) {
        parserDelegateTrackCount=1;
   
    }
    else if (parserDelegateTrackCount==2)
    {
        parserDelegateTrackCount=1;
    }
    if ([self.elementString isEqualToString:@"LastModifiedDateTime"]) {
        AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.xmlDate = string;
    }
    
    if ([self.elementString isEqualToString:@"Title"]) {
        
        [itemDict setValue:elementString forKey:@"Title"];
    }
    if ([self.elementString isEqualToString:@"Description"]) {
        
        [itemDict setValue:elementString forKey:@"Description"];
        
    }
    if ([self.elementString isEqualToString:@"PublishDate"]) {
        
        [itemDict setValue:elementString forKey:@"PublishDate"];
        
    }
    if ([self.elementString isEqualToString:@"Sequence"]) {
        
        [itemDict setValue:elementString forKey:@"Sequence"];
        
    }
    if ([self.elementString isEqualToString:@"LocationPath"]) {
        
        [itemDict setValue:elementString forKey:@"LocationPath"];
        
    }
    if ([self.elementString isEqualToString:@"image"]) {
        
        [itemDict setValue:elementString forKey:@"image"];
        
    }
    if([self.elementString isEqualToString:@"TargetPath"])
    {
        [itemDict setValue:elementString forKey:@"TargetPath"];
        
    }
    if([self.elementString isEqualToString:@"Source"])
    {
        [itemDict setValue:elementString forKey:@"Source"];
        
    }
    
    if([self.elementString isEqualToString:@"SourcePath"])
    {
        [itemDict setValue:elementString forKey:@"SourcePath"];
    }
    if([self.elementString isEqualToString:@"Category"])
    {
        [itemDict setValue:elementString forKey:@"Category"];
    }
    if([self.elementString isEqualToString:@"tinyURL"])
    {
        [itemDict setValue:elementString forKey:@"tinyURL"];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    elementString = nil;
    
    if (parserDelegateTrackCount==0) {
        parserDelegateTrackCount=2;
        
        //new line added may 30 by arshad
        [itemDict setValue:@"" forKey:elementName];
    }
    else if(parserDelegateTrackCount==1)
    {
        self.elementString=@"";
    }
    if ([elementName isEqualToString:@"Item"]) {
        [itemDictArray addObject:itemDict];
    }
    if ([elementName isEqualToString:@"News"]) {
        [parentDict setValue:itemDictArray forKey:@"News"];
        [parentDictArray addObject:parentDict];
    }
    if ([elementName isEqualToString:@"Videos"]) {
        [parentDict setValue:itemDictArray forKey:@"Videos"];
        [parentDictArray addObject:parentDict];
    }
    if ([elementName isEqualToString:@"CaseStudies"]) {
        [parentDict setValue:itemDictArray forKey:@"CaseStudies"];
        [parentDictArray addObject:parentDict];
    }
    if ([elementName isEqualToString:@"Whitepapers"]) {
        [parentDict setValue:itemDictArray forKey:@"Whitepapers"];
        [parentDictArray addObject:parentDict];
        
        
    }
    if ([elementName isEqualToString:@"WhatsNew"]) {
        [parentDict setValue:itemDictArray forKey:@"WhatsNew"];
        [parentDictArray addObject:parentDict];
        
        
    }
    
    
    // Added by amar on aprl 2015
    
    if([elementName isEqualToString:@"BannerImages"]){
        [parentDict setValue:itemDictArray forKeyPath:@"BannerImages"];
        [parentDictArray addObject:parentDict];
       
    
    }
    
    
    
    if ([elementName isEqualToString:@"ChangeSet"]) {
        [parentDict setValue:itemDictArray forKey:@"ChangeSet"];
        [parentDictArray addObject:parentDict];
        
        
    }
    
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"ParentDictionaryArray %@",parentDictArray);
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate.arrChangeSetParsedData=parentDictArray;
    if (appDelegate.reloadWhatsNew==1) {
     [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadWhatsNew" object:nil userInfo:nil];
    }
  /*
    if([[[[parentDictArray lastObject]allKeys]objectAtIndex:0]isEqualToString:@"ChangeSet"])
    {
        NSArray *arrChangeSetVal=[[parentDictArray lastObject]valueForKey:@"ChangeSet"];
        if([arrChangeSetVal count]>0)
        {
            // Download file from source path
            // Replace/Add file in document directory
          //  [self changeSet];
            
            
        }
    }
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"dataParsed" object:nil userInfo:dict];
   */
}

-(void)changeSet:(NSMutableArray*)changeSetArray
{
    
    for (int changeSetCount = 0; changeSetCount<[changeSetArray count]; changeSetCount++) {
        NSMutableDictionary* linkToDownloadandSave = [[NSMutableDictionary alloc]init];
        linkToDownloadandSave= [changeSetArray objectAtIndex:changeSetCount];
        [linkToDownloadandSave setValue:@"YES" forKey:@"downloadHTML"];
        XMLDownload *objXMLDownload=[[XMLDownload alloc]init];
        [objXMLDownload downloadXML:linkToDownloadandSave];
    }
}

-(void)fetchingChangesInChangeset:(NSArray*)arrParsedData
{
//    
//    for (id path in arrParsedData) {
//        
//    }
}

@end
