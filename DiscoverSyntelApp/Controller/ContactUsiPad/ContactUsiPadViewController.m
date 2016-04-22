//
//  ContactUsiPadViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 6/2/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ContactUsiPadViewController.h"

@interface ContactUsiPadViewController ()

@end

@implementation ContactUsiPadViewController
@synthesize contactUsmapiPadViewController, contactUsWebViewController;

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
    self.title=@"Contact Us";
    [self loadInitialView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)segmentControlSelectionContactUs:(id)sender
{
    if(mapViewNContactView.subviews.count>0)
    {
        [[mapViewNContactView.subviews objectAtIndex:0]removeFromSuperview];
    }
    
    if(segmentControl.selectedSegmentIndex==0)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        contactUsWebViewController = (WebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewControllerSyntelContent"];
        contactUsWebViewController.strWebViewTitle=@"Contact Us";
        [contactUsWebViewController.view setFrame:CGRectMake(0, 0, mapViewNContactView.frame.size.width, mapViewNContactView.frame.size.height)];
        [mapViewNContactView addSubview:contactUsWebViewController.view];
    }
    
    else if(segmentControl.selectedSegmentIndex==1)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        contactUsmapiPadViewController = (ContactUsmapiPadViewController*)[mainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"ContactUsMapVCiPad"];
        
        
        [mapViewNContactView addSubview:contactUsmapiPadViewController.view];
    }
    
}
-(void)loadInitialView
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    contactUsWebViewController = (WebViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"WebViewControllerSyntelContent"];
    contactUsWebViewController.strWebViewTitle=@"Contact Us";
    [contactUsWebViewController.view setFrame:CGRectMake(0, 0, mapViewNContactView.frame.size.width, mapViewNContactView.frame.size.height)];
    
    [mapViewNContactView addSubview:contactUsWebViewController.view];
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
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

/*
 {
 "country" :
 [
 {
 "country_Name" : "North America",
 "address" :
 [
 {
 "title":"Troy, Michigan, USA",
 "companyName":"Syntel Inc.",
 "street":"525 E. Big Beaver Road, Third Floor, Troy,",
 "address":"Michigan\nMI 48083\nUSA",
 "tel":"Tel: 248/619-2800"
 },
 
 
 {
 "title":"New York, USA",
 "companyName":"Syntel Inc.",
 "street":"One Exchange Plaza, 55 Broadway,",
 "address":"20th Floor, New York,\nNew York\nNY 10006\nUSA",
 "tel":"Tel: 212/785-9810"
 },
 
 
 {
 "title":"Miami, Florida, USA",
 "companyName":"Syntel Inc.",
 "street":"1001 Brickell Bay Drive, Suite 3102,",
 "address":"Miami\nFlorida\nFL 33131\nUSA",
 "tel":"Tel: 248/619-2800"
 },
 
 {
 "title":"Schaumburg, Illinois, USA",
 "companyName":"Syntel Inc.",
 "street":"1701 E. Woodfield Road, Suite 905,",
 "address":"Schaumburg,\nIllinois\nIL 60173\nUSA",
 "tel":"Tel: 847/413-0725"
 },
 
 {
 "title":"Schaumburg, Illinois, USA",
 "companyName":"Syntel Inc.",
 "street":"1701 E. Woodfield Road, Suite 905,",
 "address":"Schaumburg,\nIllinois\nIL 60173\nUSA",
 "tel":"Tel: 847/413-0725"
 },
 
 {
 "title":"Natick, Massachusetts, USA",
 "companyName":"Syntel Inc.",
 "street":"24 Prime Parkway, Suite 306,",
 "address":"Natick,\nMassachusetts\nMA 01760\nUSA",
 "tel":"Tel: 847/413-0725"
 },
 
 {
 "title":"Cary, North Carolina, USA",
 "companyName":"Syntel Inc.",
 "street":"1100 Crescent Green, Suite 212,",
 "address":"Cary,\nNorth Carolina\nNC 27511\nUSA",
 "tel":"Tel: 919/233-6200"
 },
 
 {
 "title":"Nashville, Tennessee, USA",
 "companyName":"Syntel Inc.",
 "street":"105 West Park Drive, Suite 300,",
 "address":"Nashville,\nBrentwood\nTN 37027\nUSA",
 "tel":"Tel: 615/312-7610"
 },
 
 {
 "title":"Memphis, Tennessee, USA",
 "companyName":"Syntel Inc.",
 "street":"3242 Players Club Circle, 2nd Floor, Memphis,",
 "address":"Tennessee,\nTN 38125\nUSA",
 "tel":"Tel: 901/748-3622"
 },
 
 {
 "title":"Phoenix, Arizona, USA",
 "companyName":"Syntel Inc.",
 "street":"2902 West Agua Fria Freeway, Suite 1020,",
 "address":"Phoenix,\nArizona\nAZ 85027\nUSA",
 "tel":"Tel: 623/780-5800"
 },
 
 {
 "title":"Irving, Texas, USA",
 "companyName":"Syntel Inc.",
 "street":"Waterfront Towers, 433 E. Las Colinas Blvd.,",
 "address":"Suite 1150, Irving,\nTexas\nTX 75039\nUSA"
 },
 
 {
 "title":"Sparks, Maryland, USA",
 "companyName":"Syntel, Inc.",
 "street":"14600 York Road, Sparks,",
 "address":"Maryland,\nMD 21152\nUSA"
 },
 
 {
 "title":"Tornoto, Ontario, Canada, USA",
 "companyName":"Syntel Inc.",
 "street":"48 Yonge Street, Suite 610, Sparks,",
 "address":"Tornoto,\nON M5E 1G6\nCanada",
 "tel":"Tel: 647/725-5060"
 }
 ]
 },
 {
 "country_Name" : "Asia",
 "address" :
 [
 {
 "title":"Navi Mumbai, India, USA",
 "companyName":"Syntel Limited",
 "street":"Building No. 4, Mindspace Thane",
 "address":"Belapur Road, Airoli,\nNavi Mumbai\n400 708\nIndia",
 "tel":"Tel: 91-22 4113 2200"
 },
 {
 "title":"Chennai, India",
 "companyName":"Syntel International Pvt. Ltd.",
 "street":"Plot No. H7 & H8, SIPCOT IT Park",
 "address":"Navallur Post, Siruseri,\nKanchipuram District,\nChennai\n603 103\nIndia",
 "tel":"Tel: 91-44-4742 3800"
 },
 
 {
 "title":"Pune, India",
 "companyName":"Syntel Limited.",
 "street":"Plot No. A-33 & A-34,MIDC IT Tower",
 "address":"MIDC Talawade Software Technology Park.\nPune,\nMaharashtra\n412114\nIndia",
 "tel":""
 },
 
 {
 "title":"Mumbai, India",
 "companyName":"Syntel Limited.",
 "street":"A-501 Winchester, Hiranandani",
 "address":"Business Park, Powai,\nMumbai,\n400 076\nIndia",
 "tel":"Tel:91-22 4011 9200"
 },
 
 {
 "title":"Mumbai, India",
 "companyName":"Syntel Limited.",
 "street":"101-104 Delphi, 1st Floor,",
 "address":"Hiranandani Business Park, Powai,\nMumbai,\n400 076\nIndia",
 "tel":"Tel:91-22 6704 6402 / 64"
 },
 
 {
 "title":"Pune, India",
 "companyName":"Syntel Limited.",
 "street":"MIDC Software Technology Park,Talawade,",
 "address":"Pune,\n412114\nIndia",
 "tel":"Tel:91-20-6615-1000"
 },
 
 {
 "title":"Pune, India",
 "companyName":"Syntel Limited.",
 "street":"2nd Floor,Wing B,SEZ Building 4,",
 "address":"SP Infocity,\nSurvey #209,Phursungi\nPune\n412308\nIndia",
 "tel":"Tel:91-20-4064 2000"
 },
 {
 "title":"Chennai, India",
 "companyName":"Syntel Limited.",
 "street":"117/1 Arihant ePark, Lattice Bridge Road (LB Road), Adyar,",
 "address":"Chennai,\n600 020\nIndia",
 "tel":"Tel:91-44-2440 7500"
 },
 {
 "title":"Chennai, India",
 "companyName":"Syntel Limited.",
 "street":"SEZ Unit, 6th Floor, Block 1A, DLF IT Park, 1/124 Shivaji Gardens,",
 "address":"Moonlight Stop, Nandambakkam Post, Ramapuram,\nMount Poonamalle Road,\nChennai\n600 089\nIndia",
 "tel":"Tel:91-44-2252 7050"
 },
 
 {
 "title":"Gurgaon, India",
 "companyName":"Syntel Limited.",
 "street":"Ramprastha,Plot No.114,Sector 44,Gurgaon,",
 "address":"Haryana,\nMount Poonamalle Road,\nIndia",
 "tel":""
 },
 
 
 {
 "title":"Singapore, Singapore",
 "companyName":"Syntel (Singapore) Pte. Ltd.",
 "street":"1 North Bridge Road, #19-04/05 High Street Centre,",
 "address":"Singapore,\n179094,\nSingapore",
 "tel":"Tel:65- 6337 2475"
 },
 
 {
 "title":"Manila, Philippines",
 "companyName":"Syntel Infotech.",
 "street":"10th Floor, Science Hub Tower 3,",
 "address":"McKinley Hill Cyber Park, Fort,\nBonifacio, Taguig City,\nManila\n1634",
 "tel":""
 },
 
 {
 "title":"Manila, Philippines",
 "companyName":"Syntel Infotech.",
 "street":"10th Floor, Science Hub Tower 3,",
 "address":"McKinley Hill Cyber Park, Fort,\nBonifacio, Taguig City,\nManila\n1634",
 "tel":""
 }
 ]
 },
 
 {
 "country_Name" : "Europe",
 "address" :
 [
 {
 "title":"London, United Kingdom",
 "companyName":"Syntel Europe Ltd.",
 "street":"Bolsover House, 5 Clipstone Street,",
 "address":"London\nW1W 6BB\nUnited Kingdom",
 "tel":"Tel: 44-0207-636 3587"
 },
 
 {
 "title":"Dublin, Ireland",
 "companyName":"Syntel Europe Ltd.",
 "street":"41 Central Chambers, Dame Court,",
 "address":"Muenchen\nDublin\n2\nIreland",
 "tel":""
 },
 
 {
 "title":"Muenchen, Germany",
 "companyName":"Syntel Deutschland GmbH",
 "street":"Landsberger Strasse 302,",
 "address":"Muenchen\n80687\nGermany",
 "tel":"Tel: 49 (89) 9040 5234"
 },
 
 {
 "title":"Stuttgart, Germany",
 "companyName":"Syntel Deutschland GmbH",
 "street":"Industriestrasse 4,",
 "address":"Stuttgart\n70565\nGermany",
 "tel":"Tel:49 (0) 711 4904796-0"
 },
 
 {
 "title":"Paris, France",
 "companyName":"Intellisourcing SARL",
 "street":"ABC LIV, 111 Avenue Victor Hugo,",
 "address":"Paris\n75784\nFrance",
 "tel":""
 }
 
 
 
 ]
 },
 
 {
 "country_Name" : "Australia",
 "address" :
 [
 {
 "title":"Sydney, Australia",
 "companyName":"Syntel Australia  Pvt Ltd",
 "street":"Level 13 Citigroup,2 Park Street,",
 "address":"Sydney,\nAustralia",
 "tel":""
 }]}
 
 ]
 }
 */


@end
