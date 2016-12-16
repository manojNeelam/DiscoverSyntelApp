//
//  IndustrySolutionsVC.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 12/13/16.
//  Copyright © 2016 Mobile Computing. All rights reserved.
//

#import "IndustrySolutionsVC.h"
#import "IndustrySolutionsData.h"
#import "WebViewDisplayLinksIphone.h"

@interface IndustrySolutionsVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *industrySolutionList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation IndustrySolutionsVC

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndustrySolutions"];
    if(cell ==  nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndustrySolutions"];
    }
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftArrow@1x"]];
    IndustrySolutionsData *industrySolData = [industrySolutionList objectAtIndex:indexPath.row];
    [cell.textLabel setText:industrySolData.title];
    
    return cell;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return industrySolutionList.count;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
