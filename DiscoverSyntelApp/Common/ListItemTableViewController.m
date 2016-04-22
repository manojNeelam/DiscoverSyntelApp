//
//  ListItemTableViewController.m
//  PerformINS
//
//  Created by Aniket Bidwai on 31/03/14.
//  Copyright (c) 2014 syntel. All rights reserved.
//

#import "ListItemTableViewController.h"
#import "NewsListCellController.h"
#import "WhatsNewCellController.h"
#import "DataConnection.h"

@interface ListItemTableViewController ()

@end

@implementation ListItemTableViewController
@synthesize listArray;
@synthesize delegate;
@synthesize selectedButton;


- (id)initWithStyle:(UITableViewStyle)style andListArray:(NSMutableArray*) array andButton:(UIButton*) button andIdentifier:(NSString*)identifier
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        listArray = [[NSMutableArray alloc]initWithArray:array];
        strIdentifier=identifier;
        
        // change done by aamar on aprl 2015
        
        arrThoughtLeadership=[[NSArray alloc]initWithObjects:@"Videos",@"CaseStudies",@"Whitepapers",nil];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([strIdentifier isEqualToString:@"WhatsNew"])
    {
        static NSString *CellIdentifier = @"WhatsNewCellController";
        objWhatsNewCellController = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (objWhatsNewCellController == nil)
        {
            objWhatsNewCellController=[[[NSBundle mainBundle]loadNibNamed:@"WhatsNewCellController" owner:self options:nil] objectAtIndex:0];
        }
        objWhatsNewCellController.selectionStyle=UITableViewCellSelectionStyleNone;
        objWhatsNewCellController.backgroundColor=[UIColor clearColor];
        NSString *strPubDate=[[listArray objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
        NSArray *arrPubDate=[strPubDate componentsSeparatedByString:@" "];
        
        objWhatsNewCellController.otlLblTitle.text=[[listArray objectAtIndex:indexPath.row]valueForKey:@"Title"];
        objWhatsNewCellController.otlLblPubDate.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[arrPubDate objectAtIndex:0],[arrPubDate objectAtIndex:1],[arrPubDate objectAtIndex:2],[arrPubDate objectAtIndex:3]];
        
        
     //  objWhatsNewCellController.otlLblPubDate.text=[NSString stringWithFormat:@"%@ %@ ",[arrPubDate objectAtIndex:0],[arrPubDate objectAtIndex:1]];

        
        
        objWhatsNewCellController.otlLblDescription.text=[[listArray objectAtIndex:indexPath.row]valueForKey:@"Description"];
        if([arrThoughtLeadership containsObject:[[listArray objectAtIndex:indexPath.row ]valueForKey:@"Category"]])
        {
            objWhatsNewCellController.otlImageWhatsNew.image=[UIImage imageNamed:@"ThoughtLeadershipSymbol.png"];
        }
        else if ([[[listArray objectAtIndex:indexPath.row ]valueForKey:@"Category"]isEqualToString:@"News"])
        {
            objWhatsNewCellController.otlImageWhatsNew.image=[UIImage imageNamed:@"NewsSymbol.png"];
        }
        
        return objWhatsNewCellController;
        

    }
    else if ([strIdentifier isEqualToString:@"News"])
    {
        static NSString *CellIdentifier = @"NewsListCellIdentifier";
        objNewsListCellController = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (objNewsListCellController == nil)
        {
            objNewsListCellController=[[[NSBundle mainBundle]loadNibNamed:@"NewsListCellController" owner:self options:nil] objectAtIndex:0];
        }
        objNewsListCellController.selectionStyle=UITableViewCellSelectionStyleNone;
        objNewsListCellController.backgroundColor=[UIColor clearColor];
        NSString *strPubDate=[[listArray objectAtIndex:indexPath.row]valueForKey:@"PublishDate"];
        NSArray *arrPubDate=[strPubDate componentsSeparatedByString:@" "];
        
        objNewsListCellController.otlLblTitle.text=[[listArray objectAtIndex:indexPath.row]valueForKey:@"Title"];
        objNewsListCellController.otlLblPubDate.text=[NSString stringWithFormat:@"%@ %@ %@ %@",[arrPubDate objectAtIndex:0],[arrPubDate objectAtIndex:1],[arrPubDate objectAtIndex:2],[arrPubDate objectAtIndex:3]];
        objNewsListCellController.otlLblDescription.text=[[listArray objectAtIndex:indexPath.row]valueForKey:@"Description"];
        [objNewsListCellController.otlLblDescription sizeToFit];
          return objNewsListCellController;
        

    }
    
    
           return objNewsListCellController;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DataConnection *objDataConnection=[[DataConnection alloc]init];
    if([objDataConnection networkConnection]){
    NSString *strLocationPath=[[listArray objectAtIndex:indexPath.row]valueForKey:@"LocationPath"];
    NSString *strValTitle=[[listArray objectAtIndex:indexPath.row]valueForKey:@"Title"];
    
    NSMutableDictionary *dicTemp=[NSMutableDictionary dictionary];
    [dicTemp setValue:strLocationPath forKey:@"LocationPath"];
    [dicTemp setValue:strValTitle forKey:@"Title"];
    NSString *strTinyURL;
    if([[listArray objectAtIndex:indexPath.row]valueForKey:@"tinyURL"]==nil||[[[[listArray objectAtIndex:indexPath.row]valueForKey:@"tinyURL"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        strTinyURL=[[listArray objectAtIndex:indexPath.row]valueForKey:@"Source"];
    }
    else
    {
        strTinyURL=[[listArray objectAtIndex:indexPath.row]valueForKey:@"tinyURL"];
    }
    
    [dicTemp setValue:strTinyURL forKey:@"tinyURL"];
    NSString *strCategory;
    if([[[listArray objectAtIndex:indexPath.row]valueForKey:@"Category"] isEqualToString:@"CaseStudies"]){
        strCategory=CaseStudies;
    }
    else if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"Category"] isEqualToString:@"Whitepapers"]){
        strCategory=WhitePapers;
    }
    else if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"Category"] isEqualToString:@"Videos"]){
        strCategory=Videos;
    }
    else if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"Category"] isEqualToString:@"News"])
    {
        strCategory=News;
    }
        
        //Added by Amar aprl 2015
        
    else if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"Category"] isEqualToString:@"BannerImage"]){
        //strCategory = BannerImage;
    }
        
        
        
        
        
    
    
    [dicTemp setValue:strCategory forKey:@"Category"];
    [self performSelector:@selector(sendMsgToProtocolMethod:) withObject:dicTemp afterDelay:0.1];
    }
   
}

-(void) sendMsgToProtocolMethod:(NSMutableDictionary*) dicContentPassed
{
    [delegate selectedItemDetails:dicContentPassed];
}

@end
