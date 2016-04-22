//
//  ContactContentViewController.m
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import "ContactContentViewController.h"
#import "SyntelAddressData.h"
#import "ContactContentData.h"

@interface ContactContentViewController ()
{
    NSArray *listOfCountry;
}
@end

@implementation ContactContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    // Do any additional setup after loading the view.
    
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
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
