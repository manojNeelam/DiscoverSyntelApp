//
//  ContactContentData.h
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactContentData : NSObject
@property (nonatomic, strong) NSString *countryTitle;
@property (nonatomic, strong) NSArray *addressList;

@property (nonatomic, assign) BOOL isOpen;
-(id)initwithDictionary:(NSDictionary *)dict;

@end
