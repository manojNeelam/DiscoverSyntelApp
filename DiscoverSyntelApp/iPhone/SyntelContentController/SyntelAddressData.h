//
//  SyntelAddressData.h
//  DiscoverSyntelApp
//
//  Created by Syntel-Amargoal1 on 4/21/16.
//  Copyright (c) 2016 Mobile Computing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyntelAddressData : NSObject
@property (nonatomic, strong) NSString *title, *companyName, *address, *contact, *street;

-(id)initwithDictionary:(NSDictionary *)dict;

@end
