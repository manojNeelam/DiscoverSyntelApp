//
//  IndustrialOfferingsViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/23/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "IndustrialOfferingsViewController.h"
#import "WebViewDisplayLinks.h"

@interface IndustrialOfferingsViewController ()

@end

@implementation IndustrialOfferingsViewController

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
	arrOfferingsMenu=[[NSMutableArray alloc]initWithObjects:@"Banking And Financial Services",@"Healthcare And Life Sciences",@"Insurance",@"Logistics",@"Manufacturing",@"Retail",@"Telecom", nil];
    isMenuOptionSelected=NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    isMenuOptionSelected=NO;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    isMenuOptionSelected=NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ActionHandler
-(IBAction)onClickOfferings:(UIButton*)sender
{
    if(!isMenuOptionSelected){
    indexValueInArray=(int)sender.tag;
    NSString *strSelectedLabelTitle= [arrOfferingsMenu objectAtIndex:indexValueInArray];
    
    // Fetching Respective offering folder from document directory
    NSString *strDirectoryName=[self fetchOfferingsDirectory:indexValueInArray];
    
    // Fetching File url
    NSString *strOfferingsFileUrl=nil;
    if(strDirectoryName!=nil)
    {
        strOfferingsFileUrl=[self fetchFilePath:strDirectoryName];
    }
   
    dictionaryContenets=[[NSMutableDictionary alloc]init];
    NSDictionary *dicSourceUrl=[self fetchOfferingsUrl];
    [dictionaryContenets setValue:[[dicSourceUrl objectForKey:@"IndustryOfferingsUrl"]objectAtIndex:indexValueInArray] forKey:@"SourceUrl"];
    [dictionaryContenets setValue:strSelectedLabelTitle forKey:@"Title"];
    [dictionaryContenets setValue:strOfferingsFileUrl forKey:@"FilePath"];
    [dictionaryContenets setValue:strOfferingsFileUrl  forKey:@"URL"];
    [dictionaryContenets setValue:strSelectedLabelTitle forKey:@"PageTitle"];
    [dictionaryContenets setValue:[[dicSourceUrl objectForKey:@"IndustryOfferingsUrl"]objectAtIndex:indexValueInArray] forKey:@"tinyURL"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    WebViewDisplayLinks *objWebViewDisplayLinks = (WebViewDisplayLinks*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinks"];
    objWebViewDisplayLinks.dicOfContentLoaded=dictionaryContenets;
    [self.navigationController pushViewController:objWebViewDisplayLinks animated:YES];
        isMenuOptionSelected=YES;
    }
    
    
}

-(NSString*)fetchOfferingsDirectory:(int)index
{
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   // NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
   // NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"tmp" isDirectory:YES];
    
    NSError * error;
    
    NSString *directoryHtml=[NSString stringWithFormat:@"%@%@",[[documentDirURL path] stringByAppendingString:@"/Webcontent/HTML/"],IndustryOfferingsFolder];
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
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
   // NSURL *tmpDir = [[documentDirURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"tmp" isDirectory:YES];

    NSError * error;
    NSString *directoryHtml=[NSString stringWithFormat:@"%@%@",[[documentDirURL path] stringByAppendingString:@"/Webcontent/HTML/"],[IndustryOfferingsFolder stringByAppendingPathComponent:directoryName]];
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
-(NSDictionary*)fetchOfferingsUrl
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DiscoverSyntelDataModel" ofType:@"plist"];
    NSMutableDictionary *dicUrl = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return dicUrl;
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
