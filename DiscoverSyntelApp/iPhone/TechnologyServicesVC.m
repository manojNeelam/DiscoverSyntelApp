//
//  TechnologyServicesVC.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 12/13/16.
//  Copyright © 2016 Mobile Computing. All rights reserved.
//

#import "TechnologyServicesVC.h"
#import "TechnologyServicesData.h"
#import "WebViewDisplayData.h"
#import "WebViewDisplayLinksIphone.h"

@interface TechnologyServicesVC ()
{
    NSMutableArray *technologyServiceList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TechnologyServicesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    [self.navigationItem setTitle:@"Technology Services"];
    
    technologyServiceList = [[NSMutableArray alloc] init];//WithArray:[self loadData]];
    technologyServiceList = [self loadData];
    
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
    TechnologyServicesData *technologySerData = [technologyServiceList objectAtIndex:indexPath.row];
    [cell.textLabel setText:technologySerData.title];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TechnologyServicesData *technologySerData = [technologyServiceList objectAtIndex:indexPath.row];
    
    NSString *filePath = [self fetchFilePath:technologySerData.key];
    
    WebViewDisplayData *objWebDisplayData = [[WebViewDisplayData alloc]init];
    objWebDisplayData.strPageTitle = technologySerData.title;
    
    objWebDisplayData.strSourceURL = technologySerData.tinyURL;
    objWebDisplayData.strTinyURLDisplay = technologySerData.tinyURL;
    
    objWebDisplayData.strURLDisplay = filePath;
    objWebDisplayData.strFilePath = filePath;
    objWebDisplayData.strTitleDisplay = technologySerData.title;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    WebViewDisplayLinksIphone *objWebViewDisplayLinksIphone = (WebViewDisplayLinksIphone*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewDisplayLinksIphone"];
    objWebViewDisplayLinksIphone.webViewDisplayDataReceived=objWebDisplayData;
    [self.navigationController pushViewController:objWebViewDisplayLinksIphone animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return technologyServiceList.count;
}

-(NSMutableArray *)loadData
{
    NSMutableArray *dummy = [NSMutableArray array];
    TechnologyServicesData *technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Application Lifecycle";
    technologySerData.key = @"ALC";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/application-lifecycle";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Cloud";
    technologySerData.key = @"Cloud";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/cloud";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Data & Insights";
    technologySerData.key = @"DI";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/data-and-insights";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Syntel Digital One";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/syntel-digital-one";
    technologySerData.key = @"DO";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Enterprise Solutions";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/enterprise-solutions";
    technologySerData.key = @"ERS";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"IT Infrastructure Management";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/it-infrastructure-management";
    technologySerData.key = @"ITM";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Legacy Modernization";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/legacy-modernization";
    technologySerData.key = @"LM";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Mobility Solutions";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/mobility-solutions";
    technologySerData.key = @"MOB";
    [dummy addObject:technologySerData];
    
    technologySerData = [[TechnologyServicesData alloc] init];
    technologySerData.title = @"Testing";
    technologySerData.tinyURL = @"http://www.syntelinc.com/technology-services/testing";
    technologySerData.key = @"Testing";
    [dummy addObject:technologySerData];
    
    return dummy;
}


-(NSString*)fetchFilePath:(NSString*)directoryName
{
    NSURL *documentDirURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    
    NSError * error;
    NSString *directoryHtml=[NSString stringWithFormat:@"%@%@",[[documentDirURL path] stringByAppendingString:@"/Webcontent/HTML/"],[TechnologyOfferingsFolder stringByAppendingPathComponent:directoryName]];
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
