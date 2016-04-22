 //
//  XMLParserGData.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 4/28/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "XMLParserGData.h"
#import "GDataXMLNode.h"
#import "NewsModelClass.h"
#import "VideosModelClass.h"
#import "CaseStudiesModelClass.h"
#import "WhitePapersModelClass.h"
#import "WhatsNewModelClass.h"
#import "ContentModelClass.h"
#import "AppDelegate.h"
#import "XMLParserController.h"


@implementation XMLParserGData

+ (NSString *)dataFilePath:(BOOL)forSave :(NSString*)xmlPath{
    
    
    NSString *documentsPath;
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Library/Caches" isDirectory:YES];
  //  NSString *documentPathForXML=[[tmpDir path] stringByAppendingPathComponent:@"xml"];
    

    
 //   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [tmpDir path];
         if ([xmlPath isEqualToString:@"second"]){
	documentsPath = [documentsDirectory stringByAppendingPathComponent:@"xml/WebContent2.xml"];
    }
    else {
        documentsPath = [documentsDirectory stringByAppendingPathComponent:@"xml/WebContent.xml"];
    }

    if (forSave || [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"WebContent" ofType:@"xml"];
    }
    
}


//Parsing both xml one by one
+ (ContentModelClass *)loadContent:(NSString*)xmlType
{
    NSMutableArray* changeSetArray = [[NSMutableArray alloc]init];
       NSString *filePath;
    if ([xmlType isEqualToString:@"firstXML"]) {
        filePath = [self dataFilePath:FALSE :@"first"];

    }
    else{
        filePath = [self dataFilePath:FALSE:@"second"];
    }
   
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return nil; }
    
    ContentModelClass *contentModel = [[ContentModelClass alloc] init];
    //ChangeSet parse and download
    if ([xmlType isEqualToString:@"secondXML"]) {
        AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
        NSArray *changeSetArr = [doc nodesForXPath:@"//Content/ChangeSet/Item" error:nil];
        for (GDataXMLElement *changeSetObject in changeSetArr) {
            NSMutableDictionary* changeSetDict = [[NSMutableDictionary alloc]init];
            NSArray *targetPathArr = [changeSetObject elementsForName:@"TargetPath"];
            NSArray *sourcePathArr = [changeSetObject elementsForName:@"SourcePath"];
            if (targetPathArr.count>0) {
                GDataXMLElement *targetPathVal = (GDataXMLElement *) [targetPathArr objectAtIndex:0];
                [changeSetDict setValue:targetPathVal.stringValue forKey:@"TargetPath"];
                
            }
            if (sourcePathArr.count>0) {
                GDataXMLElement *sourcePathVal = (GDataXMLElement *) [sourcePathArr objectAtIndex:0];
                [changeSetDict setValue:sourcePathVal.stringValue forKey:@"SourcePath"];
            }
            
            [changeSetArray addObject:changeSetDict];
        }
        //calling to download
        appDelegate.arrDataSourceChangeSet =changeSetArray;
        XMLParserController* objXMLParserController = [[XMLParserController alloc]init];
        [objXMLParserController changeSet:changeSetArray];
        
        //add date tag

        NSString *dateString = [[[doc.rootElement elementsForName:@"LastModifiedDateTime"] objectAtIndex:0] stringValue];
        NSLog(@"dateString : %@",dateString);
        contentModel.dateTagString = dateString;
    }

 //   NSArray *dateArr = [doc nodesForXPath:@"//Content/LastModifiedDateTime" error:nil];
//    for (GDataXMLElement *dateItemObject in dateArr) {
//        NSString *dateString;
//        GDataXMLElement *nameElement = (GDataXMLElement *) [dateArr objectAtIndex:0];
//        
//        dateString = [nameElement stringValue];
//        NewsModelClass* dateModel = [[NewsModelClass alloc]initWithName:dateString];
//        [contentModel.dateTag addObject:dateModel];
//        contentModel.dateTagString =dateString;
//    }

   //News
    NSArray *newsItemArr = [doc nodesForXPath:@"//Content/News/Item" error:nil];
   for (GDataXMLElement *newsItemObject in newsItemArr) {
        NSString *title;
        NSString *description;
       NSString *publishDate;
       NSString *locationPath;
       NSString *source;
       NSString *tinyURLString;
        // title
        NSArray *titles = [newsItemObject elementsForName:@"Title"];
        if (titles.count > 0) {
            GDataXMLElement *titleVal = (GDataXMLElement *) [titles objectAtIndex:0];
            title = titleVal.stringValue;
        }
        //description
        NSArray *descriptions= [newsItemObject elementsForName:@"Description"];
        if (descriptions.count > 0) {
            GDataXMLElement *descriptionVal = (GDataXMLElement *) [descriptions objectAtIndex:0];
            description = descriptionVal.stringValue;
        }
       //publish date
       NSArray *publishDates= [newsItemObject elementsForName:@"PublishDate"];
       if (descriptions.count > 0) {
           GDataXMLElement *publishDateVal = (GDataXMLElement *) [publishDates objectAtIndex:0];
           publishDate = publishDateVal.stringValue;
       }
       //location path
       NSArray *locationPaths= [newsItemObject elementsForName:@"LocationPath"];
       if (descriptions.count > 0) {
           GDataXMLElement *locationPathVal = (GDataXMLElement *) [locationPaths objectAtIndex:0];
           locationPath = locationPathVal.stringValue;
       }
       //source path
       NSArray *sourcePaths= [newsItemObject elementsForName:@"Source"];
       if (descriptions.count > 0) {
           GDataXMLElement *sourcePathVal = (GDataXMLElement *) [sourcePaths objectAtIndex:0];
           source = sourcePathVal.stringValue;
       }
       //tiny URL
       NSArray *tinyURLS= [newsItemObject elementsForName:@"tinyURL"];
       if (tinyURLS.count > 0) {
           GDataXMLElement *tinyPathVal = (GDataXMLElement *) [tinyURLS objectAtIndex:0];
           tinyURLString = tinyPathVal.stringValue;
       }
       
       NewsModelClass* newsModel = [[NewsModelClass alloc]initWithName:title description:description publishingDate:publishDate locationPath:locationPath sourcePath:source tinyURL:tinyURLString];
        [contentModel.itemNewsModel addObject:newsModel];
        
    }
    
    //Videos
 
    NSArray *videosItemArr = [doc nodesForXPath:@"//Content/Videos/Item" error:nil];
    for (GDataXMLElement *videosItemObject in videosItemArr) {
        NSString *title;
        NSString *description;
        NSString *publishDate;
        NSString *locationPath;
        NSString *source;
        NSString *image;
        NSString* tinyURLString;
        // tiltle
        NSArray *titles = [videosItemObject elementsForName:@"Title"];
        if (titles.count > 0) {
            GDataXMLElement *titleVal = (GDataXMLElement *) [titles objectAtIndex:0];
            title = titleVal.stringValue;
        }
        //description
        NSArray *descriptions= [videosItemObject elementsForName:@"Description"];
        if (descriptions.count > 0) {
            GDataXMLElement *descriptionVal = (GDataXMLElement *) [descriptions objectAtIndex:0];
            description = descriptionVal.stringValue;
        }
        //publish date
        NSArray *publishDates= [videosItemObject elementsForName:@"PublishDate"];
        if (publishDates.count > 0) {
            GDataXMLElement *publishDateVal = (GDataXMLElement *) [publishDates objectAtIndex:0];
            publishDate = publishDateVal.stringValue;
        }
        //location path
        NSArray *locationPaths= [videosItemObject elementsForName:@"LocationPath"];
        if (locationPaths.count > 0) {
            GDataXMLElement *locationPathVal = (GDataXMLElement *) [locationPaths objectAtIndex:0];
            locationPath = locationPathVal.stringValue;
        }
        //source path
        NSArray *sourcePaths= [videosItemObject elementsForName:@"Source"];
        if (sourcePaths.count > 0) {
            GDataXMLElement *sourcePathVal = (GDataXMLElement *) [sourcePaths objectAtIndex:0];
            source = sourcePathVal.stringValue;
        }
        //image
        NSArray *images= [videosItemObject elementsForName:@"image"];
        if (images.count > 0) {
            GDataXMLElement *imageVal = (GDataXMLElement *) [images objectAtIndex:0];
            image = imageVal.stringValue;
        }
        //tiny URL
        NSArray *tinyURLS= [videosItemObject elementsForName:@"tinyURL"];
        if (tinyURLS.count > 0) {
            GDataXMLElement *tinyPathVal = (GDataXMLElement *) [tinyURLS objectAtIndex:0];
            tinyURLString = tinyPathVal.stringValue;
        }

        
        VideosModelClass* videosModel = [[VideosModelClass alloc]initWithName:title description:description publishingDate:publishDate locationPath:locationPath image:image sourcePath:source tinyURL:tinyURLString];
        [contentModel.itemVideosModel addObject:videosModel];
        
    }

    //CaseStudies
    NSArray *caseStudiesArr = [doc nodesForXPath:@"//Content/CaseStudies/Item" error:nil];
    for (GDataXMLElement *caseStudiesItemObject in caseStudiesArr) {
        NSString *title;
        NSString *description;
        NSString *publishDate;
        NSString *locationPath;
        NSString *source;
        NSString *image;
        NSString *category;
        NSString *tinyURLString;
        // tiltle
        NSArray *titles = [caseStudiesItemObject elementsForName:@"Title"];
        if (titles.count > 0) {
            GDataXMLElement *titleVal = (GDataXMLElement *) [titles objectAtIndex:0];
            title = titleVal.stringValue;
        }
        //description
        NSArray *descriptions= [caseStudiesItemObject elementsForName:@"Description"];
        if (descriptions.count > 0) {
            GDataXMLElement *descriptionVal = (GDataXMLElement *) [descriptions objectAtIndex:0];
            description = descriptionVal.stringValue;
        }
        //publish date
        NSArray *publishDates= [caseStudiesItemObject elementsForName:@"PublishDate"];
        if (publishDates.count > 0) {
            GDataXMLElement *publishDateVal = (GDataXMLElement *) [publishDates objectAtIndex:0];
            publishDate = publishDateVal.stringValue;
        }
        //location path
        NSArray *locationPaths= [caseStudiesItemObject elementsForName:@"LocationPath"];
        if (locationPaths.count > 0) {
            GDataXMLElement *locationPathVal = (GDataXMLElement *) [locationPaths objectAtIndex:0];
            locationPath = locationPathVal.stringValue;
        }
        //source path
        NSArray *sourcePaths= [caseStudiesItemObject elementsForName:@"Source"];
        if (sourcePaths.count > 0) {
            GDataXMLElement *sourcePathVal = (GDataXMLElement *) [sourcePaths objectAtIndex:0];
            source = sourcePathVal.stringValue;
        }
        //image
        NSArray *images= [caseStudiesItemObject elementsForName:@"Image"];
        if (images.count > 0) {
            GDataXMLElement *imageVal = (GDataXMLElement *) [images objectAtIndex:0];
            image = imageVal.stringValue;
        }
        //category
        NSArray *categories= [caseStudiesItemObject elementsForName:@"Category"];
        if (categories.count > 0) {
            GDataXMLElement *categoryVal = (GDataXMLElement *) [categories objectAtIndex:0];
            category = categoryVal.stringValue;
        }
        
        //tiny URL
        NSArray *tinyURLS= [caseStudiesItemObject elementsForName:@"tinyURL"];
        if (tinyURLS.count > 0) {
            GDataXMLElement *tinyPathVal = (GDataXMLElement *) [tinyURLS objectAtIndex:0];
            tinyURLString = tinyPathVal.stringValue;
        }
        
        CaseStudiesModelClass* caseStudiesModel = [[CaseStudiesModelClass alloc]initWithName:title category:category description:description publishingDate:publishDate locationPath:locationPath image:image sourcePath:source tinyURL:tinyURLString];
        [contentModel.itemCaseStudiesModel addObject:caseStudiesModel];
    }
    
    //Whitepapers
    NSArray *whitePapersArr = [doc nodesForXPath:@"//Content/Whitepapers/Item" error:nil];
    for (GDataXMLElement *whitePapersItemObject in whitePapersArr) {
        NSString *title;
        NSString *description;
        NSString *publishDate;
        NSString *locationPath;
        NSString *source;
        NSString *image;
        NSString *category;
        NSString *tinyURLString;
        // tiltle
        NSArray *titles = [whitePapersItemObject elementsForName:@"Title"];
        if (titles.count > 0) {
            GDataXMLElement *titleVal = (GDataXMLElement *) [titles objectAtIndex:0];
            title = titleVal.stringValue;
        }
        //description
        NSArray *descriptions= [whitePapersItemObject elementsForName:@"Description"];
        if (descriptions.count > 0) {
            GDataXMLElement *descriptionVal = (GDataXMLElement *) [descriptions objectAtIndex:0];
            description = descriptionVal.stringValue;
        }
        //publish date
        NSArray *publishDates= [whitePapersItemObject elementsForName:@"PublishDate"];
        if (publishDates.count > 0) {
            GDataXMLElement *publishDateVal = (GDataXMLElement *) [publishDates objectAtIndex:0];
            publishDate = publishDateVal.stringValue;
        }
        //location path
        NSArray *locationPaths= [whitePapersItemObject elementsForName:@"LocationPath"];
        if (locationPaths.count > 0) {
            GDataXMLElement *locationPathVal = (GDataXMLElement *) [locationPaths objectAtIndex:0];
            locationPath = locationPathVal.stringValue;
        }
        //source path
        NSArray *sourcePaths= [whitePapersItemObject elementsForName:@"Source"];
        if (sourcePaths.count > 0) {
            GDataXMLElement *sourcePathVal = (GDataXMLElement *) [sourcePaths objectAtIndex:0];
            source = sourcePathVal.stringValue;
        }
        //image
        NSArray *images= [whitePapersItemObject elementsForName:@"Image"];
        if (images.count > 0) {
            GDataXMLElement *imageVal = (GDataXMLElement *) [images objectAtIndex:0];
            image = imageVal.stringValue;
        }
        //category
        NSArray *categories= [whitePapersItemObject elementsForName:@"Category"];
        if (categories.count > 0) {
            GDataXMLElement *categoryVal = (GDataXMLElement *) [categories objectAtIndex:0];
            category = categoryVal.stringValue;
        }
        //tiny URL
        NSArray *tinyURLS= [whitePapersItemObject elementsForName:@"tinyURL"];
        if (tinyURLS.count > 0) {
            GDataXMLElement *tinyPathVal = (GDataXMLElement *) [tinyURLS objectAtIndex:0];
            tinyURLString = tinyPathVal.stringValue;
        }

        
        WhitePapersModelClass* whitePapersModel = [[WhitePapersModelClass alloc]initWithName:title category:category description:description publishingDate:publishDate locationPath:locationPath image:image sourcePath:source tinyURL:tinyURLString];
        [contentModel.itemWhitePapersModel addObject:whitePapersModel];
    }
    
    //WhatsNew
    NSArray *whatsNewArr = [doc nodesForXPath:@"//Content/WhatsNew/Item" error:nil];
    for (GDataXMLElement *whatsNewItemObject in whatsNewArr) {
        NSString *title;
        NSString *description;
        NSString *publishDate;
        NSString *locationPath;
        NSString *category;
        NSString *source;
       
        // tiltle
        NSArray *titles = [whatsNewItemObject elementsForName:@"Title"];
        if (titles.count > 0) {
            GDataXMLElement *titleVal = (GDataXMLElement *) [titles objectAtIndex:0];
            title = titleVal.stringValue;
        }
        //description
        NSArray *descriptions= [whatsNewItemObject elementsForName:@"Description"];
        if (descriptions.count > 0) {
            GDataXMLElement *descriptionVal = (GDataXMLElement *) [descriptions objectAtIndex:0];
            description = descriptionVal.stringValue;
        }
        //publish date
        NSArray *publishDates= [whatsNewItemObject elementsForName:@"PublishDate"];
        if (publishDates.count > 0) {
            GDataXMLElement *publishDateVal = (GDataXMLElement *) [publishDates objectAtIndex:0];
            publishDate = publishDateVal.stringValue;
        }
        //location path
        NSArray *locationPaths= [whatsNewItemObject elementsForName:@"LocationPath"];
        if (locationPaths.count > 0) {
            GDataXMLElement *locationPathVal = (GDataXMLElement *) [locationPaths objectAtIndex:0];
            locationPath = locationPathVal.stringValue;
        }
        //category
        NSArray *categories= [whatsNewItemObject elementsForName:@"Category"];
        if (locationPaths.count > 0) {
            GDataXMLElement *categoryVal = (GDataXMLElement *) [categories objectAtIndex:0];
            category = categoryVal.stringValue;
        }
        
        //source
        NSArray *sources= [whatsNewItemObject elementsForName:@"Source"];
        if (locationPaths.count > 0) {
            GDataXMLElement *sourceVal = (GDataXMLElement *) [sources objectAtIndex:0];
            source = sourceVal.stringValue;
        }
        
        WhatsNewModelClass* whatsNewModel = [[WhatsNewModelClass alloc]initWithName:title description:description publishingDate:publishDate locationPath:locationPath category:category sourcePath:source];
        [contentModel.itemWhatsNewModel addObject:whatsNewModel];
    }
    [contentModel.finalContentArray addObject:contentModel.itemNewsModel];
    [contentModel.finalContentArray addObject:contentModel.itemVideosModel];
    [contentModel.finalContentArray addObject:contentModel.itemCaseStudiesModel];
    [contentModel.finalContentArray addObject:contentModel.itemWhitePapersModel];
    [contentModel.finalContentArray addObject:contentModel.itemWhatsNewModel];
    
      return contentModel;
 }
+ (void)saveContent:(ContentModelClass *)content :(ContentModelClass*)secondXMLContent
{
    GDataXMLElement * contentElement = [GDataXMLNode elementWithName:@"Content"];
    GDataXMLElement * newsItemElement = [GDataXMLNode elementWithName:@"News"];
    GDataXMLElement * videosItemElement = [GDataXMLNode elementWithName:@"Videos"];
    GDataXMLElement * caseStudiesItemElement = [GDataXMLNode elementWithName:@"CaseStudies"];
    GDataXMLElement * whitePapersItemElement = [GDataXMLNode elementWithName:@"Whitepapers"];
    GDataXMLElement * whatsNewItemElement = [GDataXMLNode elementWithName:@"WhatsNew"];
    GDataXMLElement * dateStringElement;
    //[GDataXMLNode elementWithName:@"LastModifiedDateTime"];
    
    //add date tag
    if (secondXMLContent.dateTagString) {
        dateStringElement = [GDataXMLNode elementWithName:@"LastModifiedDateTime" stringValue:secondXMLContent.dateTagString];

    }
  
    
//    if ([secondXMLContent.dateTag count] >0) {
//      for(NewsModelClass *dateTagStr in secondXMLContent.dateTag)
//      {
//      GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:dateTagStr.date];
//          
//      }
//    }
   

    //checking from secondXml adding news
    if ([secondXMLContent.itemNewsModel count]>0) {
        for(NewsModelClass *newsItem in secondXMLContent.itemNewsModel)
        {
            GDataXMLElement * itemNewsElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:newsItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:newsItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:newsItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:newsItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:newsItem.source];
               GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:newsItem.tinyURL];
         
            [itemNewsElement addChild:titleElement];
            [itemNewsElement addChild:descriptionElement];
            [itemNewsElement addChild:publishDateElement];
            [itemNewsElement addChild:locationPathElement];
            [itemNewsElement addChild:sourceElement];
            [itemNewsElement addChild:tinyURLElement];
            [newsItemElement addChild:itemNewsElement];
        }
 
    }
    else{
        for(NewsModelClass *newsItem in content.itemNewsModel)
        {
            GDataXMLElement * itemNewsElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:newsItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:newsItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:newsItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:newsItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:newsItem.source];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:newsItem.tinyURL];
            [itemNewsElement addChild:tinyURLElement];
            [itemNewsElement addChild:titleElement];
            [itemNewsElement addChild:descriptionElement];
            [itemNewsElement addChild:publishDateElement];
            [itemNewsElement addChild:locationPathElement];
            [itemNewsElement addChild:sourceElement];
            [newsItemElement addChild:itemNewsElement];
        }

    }
    //adding videos
    if ([secondXMLContent.itemVideosModel count]>0)
    {
        for(VideosModelClass *videosItem in secondXMLContent.itemVideosModel)
        {
            GDataXMLElement * itemVideosElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:videosItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:videosItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:videosItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:videosItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:videosItem.source];
             GDataXMLElement * imageElement =  [GDataXMLNode elementWithName:@"image" stringValue:videosItem.image];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:videosItem.tinyURL];
            [itemVideosElement addChild:tinyURLElement];
            
            [itemVideosElement addChild:titleElement];
            [itemVideosElement addChild:descriptionElement];
            [itemVideosElement addChild:publishDateElement];
            [itemVideosElement addChild:locationPathElement];
            [itemVideosElement addChild:sourceElement];
            [itemVideosElement addChild:imageElement];
            [videosItemElement addChild:itemVideosElement];
        }

    }
    else{
        for(VideosModelClass *videosItem in content.itemVideosModel)
        {
            GDataXMLElement * itemVideosElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:videosItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:videosItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:videosItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:videosItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:videosItem.source];
            GDataXMLElement * imageElement =  [GDataXMLNode elementWithName:@"Image" stringValue:videosItem.image];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:videosItem.tinyURL];
            
            [itemVideosElement addChild:tinyURLElement];
            [itemVideosElement addChild:titleElement];
            [itemVideosElement addChild:descriptionElement];
            [itemVideosElement addChild:publishDateElement];
            [itemVideosElement addChild:locationPathElement];
            [itemVideosElement addChild:sourceElement];
            [itemVideosElement addChild:imageElement];
            [videosItemElement addChild:itemVideosElement];
        }

    }
    //adding caseStudies
    if ([secondXMLContent.itemCaseStudiesModel count]>0)
    {
        for(CaseStudiesModelClass *caseStudyItem in secondXMLContent.itemCaseStudiesModel)
        {
            GDataXMLElement * itemCaseStudiesElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:caseStudyItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:caseStudyItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:caseStudyItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:caseStudyItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:caseStudyItem.source];
            GDataXMLElement * categoryElement = [GDataXMLNode elementWithName:@"Category" stringValue:caseStudyItem.category];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:caseStudyItem.tinyURL];
            [itemCaseStudiesElement addChild:tinyURLElement];
            
            [itemCaseStudiesElement addChild:titleElement];
            [itemCaseStudiesElement addChild:descriptionElement];
            [itemCaseStudiesElement addChild:publishDateElement];
            [itemCaseStudiesElement addChild:locationPathElement];
            [itemCaseStudiesElement addChild:sourceElement];
            [itemCaseStudiesElement addChild:categoryElement];
            [caseStudiesItemElement addChild:itemCaseStudiesElement];

        }
 
    }
    else{
        for(CaseStudiesModelClass *caseStudyItem in content.itemCaseStudiesModel)
        {
            GDataXMLElement * itemCaseStudiesElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:caseStudyItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:caseStudyItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:caseStudyItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:caseStudyItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:caseStudyItem.source];
            GDataXMLElement * categoryElement = [GDataXMLNode elementWithName:@"Category" stringValue:caseStudyItem.category];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:caseStudyItem.tinyURL];
            [itemCaseStudiesElement addChild:tinyURLElement];
            
            [itemCaseStudiesElement addChild:titleElement];
            [itemCaseStudiesElement addChild:descriptionElement];
            [itemCaseStudiesElement addChild:publishDateElement];
            [itemCaseStudiesElement addChild:locationPathElement];
            [itemCaseStudiesElement addChild:sourceElement];
            [itemCaseStudiesElement addChild:categoryElement];
            [caseStudiesItemElement addChild:itemCaseStudiesElement];
        }
       
    }
    //adding whitepapers
    if ([secondXMLContent.itemWhitePapersModel count]>0)
    {
        for(WhitePapersModelClass *whitePapersItem in secondXMLContent.itemWhitePapersModel)
        {
            GDataXMLElement * itemWhitepapersElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:whitePapersItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:whitePapersItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:whitePapersItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:whitePapersItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:whitePapersItem.source];
            GDataXMLElement * categoryElement = [GDataXMLNode elementWithName:@"Category" stringValue:whitePapersItem.category];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:whitePapersItem.tinyURL];
            [itemWhitepapersElement addChild:tinyURLElement];
            
            [itemWhitepapersElement addChild:titleElement];
            [itemWhitepapersElement addChild:descriptionElement];
            [itemWhitepapersElement addChild:publishDateElement];
            [itemWhitepapersElement addChild:locationPathElement];
            [itemWhitepapersElement addChild:sourceElement];
            [itemWhitepapersElement addChild:categoryElement];
            [whitePapersItemElement addChild:itemWhitepapersElement];
        }
        
    
    }
    else{
        for(WhitePapersModelClass *whitePapersItem in content.itemWhitePapersModel)
        {
            GDataXMLElement * itemWhitepapersElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:whitePapersItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:whitePapersItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:whitePapersItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:whitePapersItem.locationPath];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:whitePapersItem.source];
            GDataXMLElement * categoryElement = [GDataXMLNode elementWithName:@"Category" stringValue:whitePapersItem.category];
            GDataXMLElement * tinyURLElement = [GDataXMLNode elementWithName:@"tinyURL" stringValue:whitePapersItem.tinyURL];
            [itemWhitepapersElement addChild:tinyURLElement];
            
            [itemWhitepapersElement addChild:titleElement];
            [itemWhitepapersElement addChild:descriptionElement];
            [itemWhitepapersElement addChild:publishDateElement];
            [itemWhitepapersElement addChild:locationPathElement];
            [itemWhitepapersElement addChild:sourceElement];
            [itemWhitepapersElement addChild:categoryElement];
            [whitePapersItemElement addChild:itemWhitepapersElement];
        }
        
    }
    //adding whatsNew
    if ([secondXMLContent.itemWhatsNewModel count]>0)
    {
        for(WhatsNewModelClass *newsItem in secondXMLContent.itemWhatsNewModel)
        {
            GDataXMLElement * itemWhatsNewElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:newsItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:newsItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:newsItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:newsItem.locationPath];
              GDataXMLElement * categoryElement = [GDataXMLNode elementWithName:@"Category" stringValue:newsItem.category];
            GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:newsItem.source];
            
            
            [itemWhatsNewElement addChild:categoryElement];
            [itemWhatsNewElement addChild:titleElement];
            [itemWhatsNewElement addChild:descriptionElement];
            [itemWhatsNewElement addChild:publishDateElement];
            [itemWhatsNewElement addChild:locationPathElement];
            [itemWhatsNewElement addChild:sourceElement];
           
            [whatsNewItemElement addChild:itemWhatsNewElement];
        }
       
    }
    else{
        for(WhatsNewModelClass *newsItem in content.itemWhatsNewModel)
        {
            GDataXMLElement * itemWhatsNewElement = [GDataXMLNode elementWithName:@"Item"];
            GDataXMLElement * titleElement = [GDataXMLNode elementWithName:@"Title" stringValue:newsItem.title];
            GDataXMLElement * descriptionElement = [GDataXMLNode elementWithName:@"Description" stringValue:newsItem.description];
            GDataXMLElement * publishDateElement = [GDataXMLNode elementWithName:@"PublishDate" stringValue:newsItem.publishDate];
            GDataXMLElement * locationPathElement = [GDataXMLNode elementWithName:@"LocationPath" stringValue:newsItem.locationPath];
              GDataXMLElement * categoryElement = [GDataXMLNode elementWithName:@"Category" stringValue:newsItem.category];
             GDataXMLElement * sourceElement = [GDataXMLNode elementWithName:@"Source" stringValue:newsItem.source];
            
            
            [itemWhatsNewElement addChild:titleElement];
            [itemWhatsNewElement addChild:descriptionElement];
            [itemWhatsNewElement addChild:publishDateElement];
            [itemWhatsNewElement addChild:locationPathElement];
            [itemWhatsNewElement addChild:categoryElement];
             [itemWhatsNewElement addChild:sourceElement];
            [whatsNewItemElement addChild:itemWhatsNewElement];
            
        }
        

    }

    [contentElement addChild:dateStringElement];
    [contentElement addChild:newsItemElement];
    [contentElement addChild:videosItemElement];
    [contentElement addChild:caseStudiesItemElement];
    [contentElement addChild:whitePapersItemElement];
    [contentElement addChild:whatsNewItemElement];
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:contentElement];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:TRUE:@""];
    NSLog(@"Saving xml data to %@...", filePath);
    [xmlData writeToFile:filePath atomically:YES];
   
    //parsing new xml
    AppDelegate *appDelegate = APP_INSTANCE;
    appDelegate.reloadWhatsNew = 1;
    XMLParserController *objXMLParserController=[[XMLParserController alloc]init];
    [objXMLParserController parseXML];
    
}



@end
