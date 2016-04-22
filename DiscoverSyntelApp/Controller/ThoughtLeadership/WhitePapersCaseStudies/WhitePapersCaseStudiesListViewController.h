//
//  WhitePapersCaseStudiesListViewController.h
//  DiscoverSyntelApp
//
//  Created by Mobile Computing on 4/15/14.
//  Copyright (c) 2014 Mobile Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFListCell.h"

@interface WhitePapersCaseStudiesListViewController : UIViewController
{
    IBOutlet UITableView *otlTableViewPDF;
    NSMutableArray *arrDataSourcePDF;
    NSArray *arrDataSourceParsedData;
    PDFListCell *objPDFListCell;
    NSString *strUserDefault;
}
@property(nonatomic,strong)NSString *strIdentifier;
@end
