//
//  NetworkController.m
//  ThoughtLeaderShip
//
//  Created by Arshad Ahmad Khan on 3/8/14.
//  Copyright (c) 2014 Syntel. All rights reserved.
//

#import "NetworkController.h"
#import "AppDelegate.h"
#import "JobsNetworkController.h"

@interface NetworkController ()

@end

@implementation NetworkController
@synthesize xmlNews;


-(void)getNewsAndVideos:(NSString*)urlReceived
{
    NSString* URLAddress = urlReceived;
    // NSString* URLAddress = [NSString stringWithFormat:@"http://www.syntelinc.com/xml/youtube.xml"];
    
    
    //proxy
    NSURLCredentialStorage * credentialStorage=[NSURLCredentialStorage sharedCredentialStorage]; //(1)
    NSURLCredential * newCredential;
    newCredential=[NSURLCredential credentialWithUser:@"ak5002665" password:@"march4321$" persistence:NSURLCredentialPersistencePermanent]; //(2)
    
    NSURLProtectionSpace * mySpaceHTTP=[[NSURLProtectionSpace alloc] initWithProxyHost:@"172.26.30.153" port:8080 type:NSURLProtectionSpaceHTTPProxy realm:nil authenticationMethod:nil]; //(3)
    
    NSURLProtectionSpace * mySpaceHTTPS=[[NSURLProtectionSpace alloc] initWithProxyHost:@"172.26.30.153" port:8080 type:NSURLProtectionSpaceHTTPSProxy realm:nil authenticationMethod:nil]; //(4)
    
    [credentialStorage setCredential:newCredential forProtectionSpace:mySpaceHTTP]; //(5)
    [credentialStorage setCredential:newCredential forProtectionSpace:mySpaceHTTPS]; //(6)
    
    
    
    
    
    ///
    //  NSString* URLAddress = urlReceived;
    NSURL* url=  [NSURL URLWithString:[URLAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ];
    NSLog(@"url %@",url);
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[URLAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    //      // NSData *data = [NSData dataWithContentsOfURL:url];
    //   NSData * data = [NSURLConnection sendSynchronousRequest:request
    //                                          returningResponse:&response
    //                                                      error:&error];
    //
    //    if(data)
    //    {
    //
    //        NSLog(@"urlData %@",data);
    //        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    //        xmlParser.delegate = self;
    //        [xmlParser setShouldProcessNamespaces:YES];
    //        [xmlParser parse];
    //
    //        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //        NSLog(@"%@",str);
    //
    // }
    
    AFXMLRequestOperation *operation =
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                            self.xmlNews = [NSMutableDictionary dictionary];
                                                            NSLog(@"xmlNews %@",xmlNews);
                                                            XMLParser.delegate = self;
                                                            [XMLParser setShouldProcessNamespaces:YES];
                                                            [XMLParser parse];
                                                            
                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                            [av show];
                                                            
                                                            
                                                            AppDelegate *appDelegate=[[UIApplication sharedApplication]delegate];
                                                            [appDelegate.spinner stopAnimating];
                                                            [appDelegate.activityView removeFromSuperview];
                                                        }];
    
    
    [operation start];
    
    
    //
    //
    //
}



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.elementString = elementName;
    NSLog(@"Element started %@",elementName);
    if ([elementName isEqualToString:@"channel"]) {
        
        newsRowArray = [[NSMutableArray alloc]init];
        
    }
    if ([elementName isEqualToString:@"item"]) {
        // parentString = [[NSString alloc]init];
        parentString = elementName;
        
        
        rowDict = [[NSMutableDictionary alloc]init];
    }
    
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.elementString=@"";
    
    if ([elementName isEqualToString:@"item"]) {
        [newsRowArray addObject:rowDict];
        
    }
    
    
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"Element ended %@",self.elementString);
    if ([parentString isEqualToString:@"item"]) {
        
        
        if ([self.elementString isEqualToString:@"title"]) {
            
            [rowDict setValue:string forKey:@"title"];
            
        }
        if ([self.elementString isEqualToString:@"link"]) {
            
           // [rowDict setValue:string forKey:@"link"];
            NSString *finalValue = [string stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]
                                    ];
            if(![finalValue isEqualToString:@""])
            {
                [rowDict setValue:finalValue forKey:@"link"];
            }else
            {
                
            }
        }
        if ([self.elementString isEqualToString:@"vertical"]) {
            
            [rowDict setValue:string forKey:@"vertical"];
        }
        if ([self.elementString isEqualToString:@"horizontal"]) {
            
            [rowDict setValue:string forKey:@"horizontal"];
        }
        if ([self.elementString isEqualToString:@"pubDate"]) {
            
            [rowDict setValue:string forKey:@"pubDate"];
        }
        if ([self.elementString isEqualToString:@"image"]) {
            
            [rowDict setValue:string forKey:@"image"];
        }
        if ([self.elementString isEqualToString:@"details"]) {
            NSString *finalValue = [string stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]
                                    ];
            if(![finalValue isEqualToString:@""])
            {
                
                [rowDict setValue:string forKey:@"details"];
            }
        }
        
        
    }
    
    
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
    NSLog(@"row Dictionary Array formed %@", newsRowArray);
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setValue:newsRowArray forKey:@"parsedNews"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataParsed" object:nil userInfo:dict];
//    
//    JobsNetworkController* jobsNetworkController = [[JobsNetworkController alloc]init];
//    [jobsNetworkController getNewsAndVideos:@"http://apps.shareholder.com/rss/rss.aspx?channels=6323&companyid=SYNT"];
}


@end
