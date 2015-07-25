//
//  HCLocationPlace.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCLocationPlace : NSObject

@property long id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *phone_number;
@property (strong,nonatomic) NSString *fax;
@property (strong,nonatomic) NSString *postal_code;
@property (strong,nonatomic) NSString  *lat;
@property (strong,nonatomic) NSString  *lng;
@property long type_id;
@property (strong,nonatomic) NSDate *created_at;
@property (strong,nonatomic) NSDate *updated_at;

@end
