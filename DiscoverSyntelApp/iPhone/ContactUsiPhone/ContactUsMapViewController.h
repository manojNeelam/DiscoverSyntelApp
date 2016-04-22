//
//  ContactUsMapViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/24/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MapKit.h>

@interface ContactUsMapViewController : UIViewController
{
    IBOutlet MKMapView* mapView;
}
-(IBAction)changeStyle:(id)sender;
@end
