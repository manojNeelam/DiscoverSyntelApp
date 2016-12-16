//
//  IndustrySolutionsViewController.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 12/15/16.
//  Copyright © 2016 Mobile Computing. All rights reserved.
//

#define HEIGHT_HEADER_VIEW 65

#import "IndustrySolutionsViewController.h"
#import "IndustrySolutionsData.h"
#import "WebViewDisplayLinksIphone.h"
#import "IndustrySolutionsTableViewCell.h"

@interface IndustrySolutionsViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    NSMutableArray *industrySolutionList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation IndustrySolutionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.navigationItem setTitle:@"Industry Solutions"];
    industrySolutionList = [[NSMutableArray alloc] init];//WithArray:[self loadData]];
    industrySolutionList = [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, HEIGHT_HEADER_VIEW)];
    baseView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, baseView.frame.size.width-40, HEIGHT_HEADER_VIEW)];
    IndustrySolutionsData *industrySolData = [industrySolutionList objectAtIndex:section];
    [lbl setText:industrySolData.title];
    [lbl setTextColor:[UIColor blackColor]];
    [baseView addSubview:lbl];
    
    UITapGestureRecognizer *singleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [singleTapRecogniser setDelegate:self];
    singleTapRecogniser.numberOfTouchesRequired = 1;
    singleTapRecogniser.numberOfTapsRequired = 1;
    [baseView addGestureRecognizer:singleTapRecogniser];
    
    UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_HEADER_VIEW-1, tableView.frame.size.width, 1)];
    [sepLabel setText:@""];
    [sepLabel setBackgroundColor:[UIColor lightGrayColor]];
    [baseView addSubview:sepLabel];
    
    UIImageView *leftIndicatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-45, 20, 25, 25)];
    [leftIndicatorImg setImage:[UIImage imageNamed:@"leftArrow@1x"]];
    [baseView addSubview:leftIndicatorImg];
    
    baseView.tag = section;
    return baseView;
}

- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = gestureRecognizer.view;
    IndustrySolutionsData *industrySolData = [industrySolutionList objectAtIndex:view.tag];
    
    NSString *filePath = [self fetchFilePath:industrySolData.key];
    
    WebViewDisplayData *objWebDisplayData = [[WebViewDisplayData alloc]init];
    objWebDisplayData.strPageTitle = industrySolData.title;
    
    objWebDisplayData.strSourceURL = industrySolData.tinyURL;
    objWebDisplayData.strTinyURLDisplay = industrySolData.tinyURL;
    
    objWebDisplayData.strURLDisplay = filePath;
    objWebDisplayData.strFilePath = filePath;
    objWebDisplayData.strTitleDisplay = industrySolData.title;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebDisplayData;
    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_HEADER_VIEW;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IndustrySolutionsData *industrySolData = [industrySolutionList objectAtIndex:indexPath.row];
    
    NSString *filePath = [self fetchFilePath:industrySolData.key];
    
    WebViewDisplayData *objWebDisplayData = [[WebViewDisplayData alloc]init];
    objWebDisplayData.strPageTitle = industrySolData.title;
    
    objWebDisplayData.strSourceURL = industrySolData.tinyURL;
    objWebDisplayData.strTinyURLDisplay = industrySolData.tinyURL;
    
    objWebDisplayData.strURLDisplay = filePath;
    objWebDisplayData.strFilePath = filePath;
    objWebDisplayData.strTitleDisplay = industrySolData.title;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebDisplayData;
    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return industrySolutionList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;//industrySolutionList.count;
}



-(NSMutableArray *)loadData
{
    NSMutableArray *dummy = [NSMutableArray array];
    IndustrySolutionsData *industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Banking & Financial Services";
    industrySolData.key = @"BNFS";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/banking-and-financial-services";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Healthcare";
    industrySolData.key = @"HC";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/healthcare-and-life-sciences";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Life Sciences";
    industrySolData.key = @"LS";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/life-sciences";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Insurance";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/insurance";
    industrySolData.key = @"INS";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Manufacturing";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/manufacturing";
    industrySolData.key = @"MFG";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Retail";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/retail";
    industrySolData.key = @"RTL";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Logistics & Transportation";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/logistics";
    industrySolData.key = @"LGT";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Travel & Hospitality";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/travel-hospitality";
    industrySolData.key = @"TH";
    [dummy addObject:industrySolData];
    
    industrySolData = [[IndustrySolutionsData alloc] init];
    industrySolData.title = @"Telecom";
    industrySolData.tinyURL = @"http://www.syntelinc.com/industry-solutions/telecom";
    industrySolData.key = @"TEL";
    [dummy addObject:industrySolData];
    
    return dummy;
}


-(NSString*)fetchFilePath:(NSString*)directoryName
{
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    
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

@end
