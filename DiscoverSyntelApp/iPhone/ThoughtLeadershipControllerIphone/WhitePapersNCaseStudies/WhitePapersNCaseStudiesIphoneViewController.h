//
//  WhitePapersNCaseStudiesIphoneViewController.h
//  DiscoverSyntelApp
//
//  Created by Arshad Ahmad Khan on 5/22/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFListCelliPhone.h"

@interface WhitePapersNCaseStudiesIphoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSString *strUserDefault;
    IBOutlet UITableView *otlTableViewPDF;
    NSMutableArray *arrDataSourcePDF;
    NSArray *arrDataSourceParsedData;
    PDFListCelliPhone *objPDFListCell;
    NSString *strPageTitleIdentifier;
}
@property(nonatomic,strong)NSString *strIdentifier;
@property (nonatomic,strong)IBOutlet UITableView *otlTableViewPDF;
@property (nonatomic,strong) PDFListCelliPhone *objPDFListCell;

-(void)setDictionaryValues;
-(void)setTableViewFrames;
@end
