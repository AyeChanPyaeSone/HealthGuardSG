//
//  HealthCareSteps.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMMapper.h"
#import "HealthCareDSteps.h"
#import "HealthCareTDetail.h"
#import <Foundation/Foundation.h>
#import "RMMapper.h"

@interface HealthCareSteps : NSObject

@property (nonatomic, retain) NSDictionary* distance;
@property (nonatomic, retain) NSDictionary* duration;
@property (nonatomic, retain) NSString* html_instructions;
@property (nonatomic, retain) NSArray* steps;
@property (nonatomic, retain) NSString* travel_mode;
@property (nonatomic, retain) HealthCareTDetail* transit_details;
@property (nonatomic, retain) NSDictionary* polyline;

@end