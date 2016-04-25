//
//  SyntelContentController.m
//  DiscoverSyntelApp
//
//  Created by reema on 17/05/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#define DefaultHeight 121
#define OpenDropDown    @"openDropDown"
#define CloseDropDown   @"closeDropDown"


#import "SyntelContentController.h"
#import "DataConnection.h"
#import "SyntelAddressData.h"
#import "ContactContentData.h"
#import "ConatctContentCell.h"

@interface SyntelContentController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *listOfCountry;
}
@property (weak, nonatomic) IBOutlet UITableView *contactTableView;

@end

@implementation SyntelContentController
@synthesize strWebViewTitle;

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
    
    [self.contactTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.contactTableView setDelegate:self];
    [self.contactTableView setDataSource:self];
    
    self.title=self.strWebViewTitle;
    NSString *filePath;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *bundleRoot = [[NSBundle mainBundle] resourcePath];
    if([self.strWebViewTitle isEqualToString:@"About Us"])
    {
        
        [otlWebViewSyntelContent setHidden:NO];
        [self.contactTableView setHidden:YES];
        
        
        NSString *directoryHtml=[documentsDirectory stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_000_About_us.html"];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:directoryHtml];
        
        if(fileExists){
        filePath=directoryHtml;
        }
        else{
        filePath=[bundleRoot stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_000_About_us.html"];
        }
        
        filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:filePath];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [otlWebViewSyntelContent loadRequest:requestObj];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    else if ([self.strWebViewTitle isEqualToString:@"Contact Us"])
    {
        
        [otlWebViewSyntelContent setHidden:YES];
        [self.contactTableView setHidden:NO];
        
        NSString * filePath =[[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"json"];
        
        NSError * error;
        NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        
        
        if(error)
        {
            NSLog(@"Error reading file: %@",error.localizedDescription);
        }
        
        
        NSDictionary *dict = [NSJSONSerialization
                              JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                              options:0 error:NULL];

        
        NSArray *countryHolder = [dict objectForKey:@"country"];
        if(countryHolder.count)
        {
            NSMutableArray *temp = [NSMutableArray array];
            for(NSDictionary *dictCountry in countryHolder)
            {
                ContactContentData *contactContentData = [[ContactContentData alloc] initwithDictionary:dictCountry];
                [temp addObject:contactContentData];
            }
            
            listOfCountry = temp;
            
            [self.contactTableView reloadData];
        }
        
        
        
//        NSString *directoryHtml=[documentsDirectory stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_001_Contact_us_iPhone.html"];
//        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:directoryHtml];
//        
//        //Manoj
//        if(fileExists){
//        filePath=directoryHtml;
//        }
//        else{
//       filePath=[bundleRoot stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_001_Contact_us_iPhone.html"];
//        }
    }
   // otlWebViewSyntelContent.scalesPageToFit=YES;
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegates
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    otlBtnGoBack.hidden=YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *padding = @"document.body.style.padding='0px 0px 10px 10px';";
    [webView stringByEvaluatingJavaScriptFromString:padding];

    AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
    
    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];
    if(webView.canGoBack == YES){
        otlBtnGoBack.hidden=NO;
    }
    else{
        otlBtnGoBack.hidden=YES;
    }
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([self.strWebViewTitle isEqualToString:@"About Us"]){
    
    if(navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        DataConnection *objDataConnection=[[DataConnection alloc]init];
        if([objDataConnection networkConnection]){
        AppDelegate_iPhone *appDelegate=APP_INSTANCE_IPHONE;
        [appDelegate displayActivityIndicator:otlWebViewSyntelContent];
        }
        
    }
    }
    return YES;
}
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
-(IBAction)goToBack:(id)sender
{
    [otlWebViewSyntelContent goBack];
}


#pragma Mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(listOfCountry.count)
    {
        ContactContentData *contactContentData = [listOfCountry objectAtIndex:section];
        if(contactContentData.isOpen)
        {
            return contactContentData.addressList.count;
        }
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return listOfCountry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConatctContentCell";
    ConatctContentCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [Cell.lblAddress setNumberOfLines:0];
    
    ContactContentData *contactData = [listOfCountry objectAtIndex:indexPath.section];
    SyntelAddressData *addressData = [contactData.addressList objectAtIndex:indexPath.row];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickCall:)];
    [Cell.lblContactNUmber setTag:indexPath.row];
    [Cell.lblContactNUmber setUserInteractionEnabled:YES];
    [Cell.lblContactNUmber addGestureRecognizer:tapGesture];
    
    [Cell populateData:addressData];
    
    
    float additionalHeight;
    
    CGFloat heightTitle = [self getStreetSize:Cell.lblTitle street:Cell.lblTitle.text];
    if(heightTitle > 21)
    {
        additionalHeight = (heightTitle - 21);
        Cell.constraintTitleHeight.constant = ceilf(heightTitle) + 1;
    }
    else
    {
        Cell.constraintTitleHeight.constant = 21.0f;
    }
    
    CGFloat heightCompanyName = [self getStreetSize:Cell.lblCompany street:Cell.lblCompany.text];
    if(heightCompanyName > 21)
    {
        additionalHeight = (heightCompanyName - 21);
        Cell.constraintCompanyNameHeight.constant = ceilf(heightCompanyName) + 1;
    }
    else
    {
        Cell.constraintCompanyNameHeight.constant = 21.0f;
    }

    
    
    
    //float heightStreet;
 
//    if(heightStreet > 20)
//    {
//        additionalHeight = (heightStreet - 20);
//        Cell.constrStreetHeight.constant = ceilf(heightStreet);
//    }
    
    return Cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ContactContentData *contactData = [listOfCountry objectAtIndex:section];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, 41);
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    //colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.8
    
    UILabel *lblTitle = [[UILabel alloc] init];
    [lblTitle setFont:[UIFont fontWithName:@"Helvetica" size:16.0f]];
    [lblTitle setTextColor:[UIColor colorWithRed:0.0f/255.0f green:143.0f/255.0f blue:161.0f/255.0f alpha:1.0f]];
    [lblTitle setText:contactData.countryTitle];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setBackgroundColor:[UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.8]];
    [lblTitle setFrame:CGRectMake(20, 0, headerView.frame.size.width-40, 41)];
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.frame = CGRectMake(20, 40, tableView.frame.size.width-40, 1);
    [lbl setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:143.0f/255.0f blue:161.0f/255.0f alpha:1.0f]];
    [headerView addSubview:lbl];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = headerView.frame;
    [btn setTag:section];
    [btn addTarget:self action:@selector(onClickHeaderView:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    [headerView addSubview:lblTitle];

    
    UIImageView *img = [[UIImageView alloc] init];
    [img setFrame:CGRectMake(tableView.frame.size.width-60, 13, 15, 15)];
    
    NSString *imgName = OpenDropDown;
    if(contactData.isOpen)
    {
        imgName = CloseDropDown;
    }
    
    [img setImage:[UIImage imageNamed:imgName]];
    [headerView addSubview:img];
    
    
    return headerView;
}

-(void)onClickCall:(UIGestureRecognizer *)aGesture
{
    UILabel *lbl = (UILabel *)aGesture.view;
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",lbl.text];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
    NSLog(@"%@", lbl);
}

-(void)onClickHeaderView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ContactContentData *data = [listOfCountry objectAtIndex:btn.tag];
    data.isOpen = !data.isOpen;
    [self.contactTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConatctContentCell *cell = (ConatctContentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    float additionalHeight;
    additionalHeight = 0.0f;
    
    CGFloat heightTitle = [self getStreetSize:cell.lblTitle street:cell.lblTitle.text];
    if(heightTitle > 20)
    {
        additionalHeight = ceilf(heightTitle - 21.0f);
    }
    
    CGFloat heightCompanyName = [self getStreetSize:cell.lblCompany street:cell.lblCompany.text];
    if(heightCompanyName > 20)
    {
        additionalHeight = ceilf(additionalHeight + (heightCompanyName - 21.0f));
    }
    
    CGFloat heightAddress = [self getStreetSize:cell.lblAddress street:cell.lblAddress.text];
    
    if(heightAddress > 21)
    {
        additionalHeight = ceilf(additionalHeight + (heightAddress - 21.0f));
    }
    
    return DefaultHeight + additionalHeight;
}

-(CGFloat)getStreetSize:(UILabel *)myLabel street:(NSString *)aStreet
{
    CGSize labelSize = [aStreet sizeWithFont:myLabel.font
                                constrainedToSize:CGSizeMake(myLabel.frame.size.width, CGFLOAT_MAX)
                                    lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat labelHeight = ceilf(labelSize.height);
    
    return labelHeight;
    
    /*int lines = [myLabel.text sizeWithFont:myLabel.font
                         constrainedToSize:myLabel.frame.size
                             lineBreakMode:NSLineBreakByWordWrapping].height/16;*/
}

@end
