//
//  WebViewController.m
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/18/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#define Columns 3

#define DefaultHeight 145
#define DefaultWidth 260
#define OpenDropDown    @"openDropDown"
#define CloseDropDown   @"closeDropDown"

#import "WebViewController.h"
#import "DataConnection.h"
#import "ContactContentData.h"
#import "SyntelAddressData.h"
#import "ContactUsCollectionCell.h"
#import "contactHeaderiPadView.h"

@interface WebViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *listOfCountry;
    
    int currentCell;
}
@end

@implementation WebViewController
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self.addressCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    //[UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.8]];
    
    //UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.addressCollectionView.collectionViewLayout;
    //collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    
    self.title=self.strWebViewTitle;
    NSString *filePath;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *bundleRoot = [[NSBundle mainBundle] resourcePath];
    
	if([self.strWebViewTitle isEqualToString:@"About Us"])
    {
        
        [otlWebView setHidden:NO];
        [self.addressCollectionView setHidden:YES];
        
        NSString *directoryHtml=[documentsDirectory stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_000_About_us.html"];
        filePath=directoryHtml;
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
        [otlWebView loadRequest:requestObj];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        
    }
    else if ([self.strWebViewTitle isEqualToString:@"Contact Us"])
    {
        
        [otlWebView setHidden:YES];
        [self.addressCollectionView setHidden:NO];
        
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
            
            [self.addressCollectionView reloadData];
        }
        
        
        
//        NSString *directoryHtml=[documentsDirectory stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_001_Contact_us_iPad.html"];
//        filePath=directoryHtml;
//        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:directoryHtml];
//        
//        if(fileExists){
//            filePath=directoryHtml;
//        }
//        else{
//            filePath=[bundleRoot stringByAppendingString:@"/Webcontent/HTML/SyntelContent/Syntel_001_Contact_us_iPad.html"];
//        }
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegates
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *padding = @"document.body.style.padding='20px 20px 20px 20px';";
    [webView stringByEvaluatingJavaScriptFromString:padding];
    AppDelegate *appDelegate=APP_INSTANCE;
    [webView.scrollView setShowsHorizontalScrollIndicator:NO];

    [appDelegate.spinner stopAnimating];
    [appDelegate.activityView removeFromSuperview];


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
                AppDelegate *appDelegate=APP_INSTANCE;
                [appDelegate displayActivityIndicator:otlWebView];
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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma Mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return listOfCountry.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(collectionView.frame.size.width, 0);
    return headerSize;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactUsCollectionCell_iPad";
    ContactUsCollectionCell *Cell = (ContactUsCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [Cell layoutIfNeeded];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickCall:)];
    [Cell.lblContact setTag:indexPath.row];
    [Cell.lblContact setUserInteractionEnabled:YES];
    [Cell.lblContact addGestureRecognizer:tapGesture];
    
    
    ContactContentData *contactData = [listOfCountry objectAtIndex:indexPath.section];
    
    SyntelAddressData *addressData = [contactData.addressList objectAtIndex:indexPath.row];
    
    CGFloat heightTitle = ceilf([self getStreetSize:Cell.lblTitle street:addressData.title]);
    Cell.constraintTitleHeight.constant = ceilf(heightTitle);
    
    CGFloat heightCompany = ceilf([self getStreetSize:Cell.lblCompanyName street:addressData.companyName]);
    Cell.constraintComapnyHeight.constant = ceilf(heightCompany);

    CGFloat heightStreet = ceilf([self getStreetSize:Cell.lblStreet street:addressData.street]);
     Cell.constraintStreetHeight.constant = ceilf(heightStreet);
    
    [Cell populateData:addressData];

    return Cell;
}

-(CGFloat)getStreetSize:(UILabel *)myLabel street:(NSString *)aStreet
{
    CGSize labelSize = [aStreet sizeWithFont:myLabel.font
                           constrainedToSize:CGSizeMake(myLabel.frame.size.width, CGFLOAT_MAX)
                               lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat labelHeight = ceilf(labelSize.height);
    return labelHeight;
}

-(void)onClickCall:(UIGestureRecognizer *)aGesture
{
    UILabel *lbl = (UILabel *)aGesture.view;
    NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",lbl.text];
    NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
    NSLog(@"%@", lbl);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    float index = floorf(indexPath.row/Columns) + 1;
    if(currentCell)
    {
        
    }
    else
    {
        currentCell = (int)indexPath.row+1;
    }
    
    if(index == currentCell)
    {
     
    }
    
    CGSize size = collectionView.frame.size;
    return CGSizeMake((size.width-3)/3, DefaultHeight + 150); //+ additionalHeight;
}

-(float)getGreaterHeightfrom:(int)index
{
    float height = 0.0;
    
    for(int i=0; i<Columns; i++)
    {
        
    }
    return height;
}


-(CGFloat)getStreetSize:(UIFont *)myLabelFont withWidth:(float)width street:(NSString *)aStreet
{
    CGSize labelSize = [aStreet sizeWithFont:myLabelFont
                           constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                               lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat labelHeight = ceilf(labelSize.height);
    
    return labelHeight;
    
    /*int lines = [myLabel.text sizeWithFont:myLabel.font
     constrainedToSize:myLabel.frame.size
     lineBreakMode:NSLineBreakByWordWrapping].height/16;*/
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    //if (kind == UICollectionElementKindSectionHeader)
    //{
        contactHeaderiPadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"contactHeaderView_iPad" forIndexPath:indexPath];
    
        [headerView.lblTitle setBackgroundColor:[UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.8]];
        [headerView.lblTitle setTextColor:[UIColor colorWithRed:0.0f/255.0f green:143.0f/255.0f blue:161.0f/255.0f alpha:1.0f]];
    
    [headerView.btnToggleCell setTag:indexPath.section];
    [headerView.btnToggleCell addTarget:self action:@selector(onClickHeaderView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    ContactContentData *contactData = [listOfCountry objectAtIndex:indexPath.section];
    
    NSString *imgName = OpenDropDown;
    if(contactData.isOpen)
    {
        imgName = CloseDropDown;
    }
    
    [headerView.imgToggle setImage:[UIImage imageNamed:imgName]];
    
    
        [headerView.lblSep setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:143.0f/255.0f blue:161.0f/255.0f alpha:1.0f]];
        
        headerView.lblTitle.text = contactData.countryTitle;
        
        reusableview = headerView;
    //}
    return reusableview;
}

-(void)onClickHeaderView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ContactContentData *data = [listOfCountry objectAtIndex:btn.tag];
    data.isOpen = !data.isOpen;
    [self performSelector:@selector(reloadCollData) withObject:nil afterDelay:0.1];
}

-(void)reloadCollData
{
    [self.addressCollectionView reloadData];
}

@end
