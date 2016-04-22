//
//  ContactUsMapViewController.m
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import "ContactUsMapViewController.h"

@interface ContactUsMapViewController ()

@end

@implementation ContactUsMapViewController

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
   
    MKPointAnnotation *myAnnotationPune = [[MKPointAnnotation alloc]init];
    myAnnotationPune.coordinate = CLLocationCoordinate2DMake(18.713872, 73.784971);
    myAnnotationPune.title = @"Syntel Ltd";
    myAnnotationPune.subtitle = @"Syntel International Pvt Ltd,Talwade STP, Pune, Maharashtra";
    [mapView addAnnotation:myAnnotationPune];
    
    MKPointAnnotation *myAnnotationPuneITTower = [[MKPointAnnotation alloc]init];
    myAnnotationPuneITTower.coordinate = CLLocationCoordinate2DMake(18.704218, 73.791989);
    myAnnotationPuneITTower.title = @"Syntel Ltd";
    myAnnotationPuneITTower.subtitle = @"MIDC IT Tower Software Technology Park, Talwade, Pune, Maharashtra";
    [mapView addAnnotation:myAnnotationPuneITTower];
    
    MKPointAnnotation *myAnnotationPuneSP = [[MKPointAnnotation alloc]init];
    myAnnotationPuneSP.coordinate = CLLocationCoordinate2DMake(18.491621, 73.953100);
    myAnnotationPuneSP.title = @"Syntel Ltd";
    myAnnotationPuneSP.subtitle = @"Phursungi IT Park, SP Infocity Pune, Maharashtra";
    [mapView addAnnotation:myAnnotationPuneSP];
    
    MKPointAnnotation *myAnnotationGurgaon = [[MKPointAnnotation alloc]init];
    myAnnotationGurgaon.coordinate = CLLocationCoordinate2DMake(28.451374, 77.071673);
    myAnnotationGurgaon.title = @"Syntel Ltd";
    myAnnotationGurgaon.subtitle = @"114, Sector 44, Gurgaon, Haryana";
    [mapView addAnnotation:myAnnotationGurgaon];
    
    
    
    MKPointAnnotation *myAnnotationMumbai = [[MKPointAnnotation alloc]init];
    myAnnotationMumbai.coordinate = CLLocationCoordinate2DMake(19.179235, 73.003427);
    myAnnotationMumbai.title = @"Syntel Ltd";
    myAnnotationMumbai.subtitle = @"Airoli, Mumbai, MH";
    [mapView addAnnotation:myAnnotationMumbai];
    
    MKPointAnnotation *myAnnotationMumbaiSeepz = [[MKPointAnnotation alloc]init];
    myAnnotationMumbaiSeepz.coordinate = CLLocationCoordinate2DMake(19.124092, 72.876591);
    myAnnotationMumbaiSeepz.title = @"Syntel Ltd";
    myAnnotationMumbaiSeepz.subtitle = @"Unit No.112, SEEPZ Andheri(E) Mumbai";
    [mapView addAnnotation:myAnnotationMumbaiSeepz];
    
    MKPointAnnotation *myAnnotationMumbaiPowai = [[MKPointAnnotation alloc]init];
    myAnnotationMumbaiPowai.coordinate = CLLocationCoordinate2DMake(19.122831, 72.909684);
    myAnnotationMumbaiPowai.title = @"Syntel Ltd";
    myAnnotationMumbaiPowai.subtitle = @"101-104 Delphi, 1st Floor, Hiranandani Business Park, Powai, Mumbai";
    [mapView addAnnotation:myAnnotationMumbaiPowai];
    
    
    MKPointAnnotation *myAnnotationChennaiAdyar = [[MKPointAnnotation alloc]init];
    myAnnotationChennaiAdyar.coordinate = CLLocationCoordinate2DMake(13.005440, 80.256607);
    myAnnotationChennaiAdyar.title = @"Syntel Ltd";
    myAnnotationChennaiAdyar.subtitle = @"Srinivasa Murthy Ave, Baktavatsalm Nagar, Adyar, Chennai";
    [mapView addAnnotation:myAnnotationChennaiAdyar];
    
    MKPointAnnotation *myAnnotationChennaiManapakkam = [[MKPointAnnotation alloc]init];
    myAnnotationChennaiManapakkam.coordinate = CLLocationCoordinate2DMake(13.023369, 80.176466);
    myAnnotationChennaiManapakkam.title = @"Syntel Ltd";
    myAnnotationChennaiManapakkam.subtitle = @"SEZ Unit, 6th Floor, Block 1A, DLF IT Park, Chennai";
    [mapView addAnnotation:myAnnotationChennaiManapakkam];
    
    MKPointAnnotation *myAnnotationChennaiNaval = [[MKPointAnnotation alloc]init];
    myAnnotationChennaiNaval.coordinate = CLLocationCoordinate2DMake(12.821737, 80.217882);
    myAnnotationChennaiNaval.title = @"Syntel Ltd";
    myAnnotationChennaiNaval.subtitle = @"Old Mahabalipuram Road, Navallur Post Siruseri, Chennai";
    [mapView addAnnotation:myAnnotationChennaiNaval];
    
    
    
    MKPointAnnotation *myAnnotationChennai = [[MKPointAnnotation alloc]init];
    myAnnotationChennai.coordinate = CLLocationCoordinate2DMake(13.046999, 80.176055);
    myAnnotationChennai.title = @"Syntel Ltd";
    myAnnotationChennai.subtitle = @"Chennai, TN";
    [mapView addAnnotation:myAnnotationChennai];
    
    MKPointAnnotation *myAnnotationGermany = [[MKPointAnnotation alloc]init];
    myAnnotationGermany.coordinate = CLLocationCoordinate2DMake(48.143529, 11.501160);
    myAnnotationGermany.title = @"Syntel Ltd";
    myAnnotationGermany.subtitle = @"Syntel Deutschland GmbH, Landsberger Straße, Munich, Germany";
    [mapView addAnnotation:myAnnotationGermany];
    
    
    
    
    MKPointAnnotation *myAnnotationArizona = [[MKPointAnnotation alloc]init];
    myAnnotationArizona.coordinate = CLLocationCoordinate2DMake(33.670683, -112.123065);
    myAnnotationArizona.title = @"Syntel Inc";
    myAnnotationArizona.subtitle = @"2902 Agua Fria Fwy #1020 Phoenix, AZ 85027";
    [mapView addAnnotation:myAnnotationArizona];
    
    MKPointAnnotation *myAnnotationCA = [[MKPointAnnotation alloc]init];
    myAnnotationCA.coordinate = CLLocationCoordinate2DMake(37.381962, -121.977591);
    myAnnotationCA.title = @"Syntel Inc";
    myAnnotationCA.subtitle = @"3333 Bowers Ave #28Santa Clara, CA 95054 United States";
    [mapView addAnnotation:myAnnotationCA];
    
    MKPointAnnotation *myAnnotationIL = [[MKPointAnnotation alloc]init];
    myAnnotationIL.coordinate = CLLocationCoordinate2DMake(42.043290, -88.038239);
    myAnnotationIL.title = @"Syntel Inc";
    myAnnotationIL.subtitle = @"1701 E Woodfield Rd Schaumburg, IL 60173 United States";
    [mapView addAnnotation:myAnnotationIL];
    
    
    MKPointAnnotation *myAnnotationMassach = [[MKPointAnnotation alloc]init];
    myAnnotationMassach.coordinate = CLLocationCoordinate2DMake(42.295663, -71.355348);
    myAnnotationMassach.title = @"Syntel Inc";
    myAnnotationMassach.subtitle = @"24 Prime Park Way Natick, MA 01760 USA";
    [mapView addAnnotation:myAnnotationMassach];
    
    MKPointAnnotation *myAnnotationTroy = [[MKPointAnnotation alloc]init];
    myAnnotationTroy.coordinate = CLLocationCoordinate2DMake(42.563943, -83.137307);
    myAnnotationTroy.title = @"Syntel Inc";
    myAnnotationTroy.subtitle = @"East Big Beaver Road, Troy, MI, North America";
    [mapView addAnnotation:myAnnotationTroy];
    
    
    MKPointAnnotation *myAnnotationFlorida = [[MKPointAnnotation alloc]init];
    myAnnotationFlorida.coordinate = CLLocationCoordinate2DMake( 25.764129, -80.189934);
    myAnnotationFlorida.title = @"Syntel Inc";
    myAnnotationFlorida.subtitle = @"1001 Brickell Bay Dr Miami, FL 33131 United States";
    [mapView addAnnotation:myAnnotationFlorida];
    
    MKPointAnnotation *myAnnotationNYC = [[MKPointAnnotation alloc]init];
    myAnnotationNYC.coordinate = CLLocationCoordinate2DMake(40.706985, -74.012729);
    myAnnotationNYC.title = @"Syntel Inc";
    myAnnotationNYC.subtitle = @"1 Exchange Alley New York, NY 10006 United States";
    
    MKPointAnnotation *myAnnotationCarolina = [[MKPointAnnotation alloc]init];
    myAnnotationCarolina.coordinate = CLLocationCoordinate2DMake(35.733731, -78.781160);
    myAnnotationCarolina.title = @"Syntel Inc";
    myAnnotationCarolina.subtitle = @"1100 Crescent Green # 212 Cary, NC 27518 United States";
    [mapView addAnnotation:myAnnotationCarolina];
    
    MKPointAnnotation *myAnnotationTexas = [[MKPointAnnotation alloc]init];
    myAnnotationTexas.coordinate = CLLocationCoordinate2DMake(32.862745, -96.934423);
    myAnnotationTexas.title = @"Syntel Inc";
    myAnnotationTexas.subtitle = @"433 Las Colinas Blvd Irving, TX 75039 USA";
    [mapView addAnnotation:myAnnotationTexas];
    
    MKPointAnnotation *myAnnotationTennessee = [[MKPointAnnotation alloc]init];
    myAnnotationTennessee.coordinate = CLLocationCoordinate2DMake(36.148661, -86.808035);
    myAnnotationTennessee.title = @"Syntel Inc";
    myAnnotationTennessee.subtitle = @"206 Reidhurst Ave Nashville, TN 37203 USA";
    [mapView addAnnotation:myAnnotationTennessee];
    
    MKPointAnnotation *myAnnotationMemphis = [[MKPointAnnotation alloc]init];
    myAnnotationMemphis.coordinate = CLLocationCoordinate2DMake(35.063304, -89.790341);
    myAnnotationMemphis.title = @"Syntel Inc";
    myAnnotationMemphis.subtitle = @"3242 Players Club Pkwy, Memphis, TN 38125 USA";
    [mapView addAnnotation:myAnnotationMemphis];
    
    MKPointAnnotation *myAnnotationLondon = [[MKPointAnnotation alloc]init];
    myAnnotationLondon.coordinate = CLLocationCoordinate2DMake(51.521077, -0.142189);
    myAnnotationLondon.title = @"Syntel Europe Ltd";
    myAnnotationLondon.subtitle = @"Bolsover House 5-6 Clipstone St London W1W 6BB, UK";
    [mapView addAnnotation:myAnnotationLondon];
    
    MKPointAnnotation *myAnnotationSingapore = [[MKPointAnnotation alloc]init];
    myAnnotationSingapore.coordinate = CLLocationCoordinate2DMake(1.295569, 103.858472);
    myAnnotationSingapore.title = @"Syntel (Singapore) Pte Ltd";
    myAnnotationSingapore.subtitle = @"7 Temasek Blvd Singapore 038987";
    [mapView addAnnotation:myAnnotationSingapore];
    
    

    
      // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeStyle:(id)sender
{
    mapView.mapType =MKMapTypeStandard;
}
@end
