//
//  HealthCareTDetail.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthCareDSteps.h"
#import "HealthCareStepLine.h"

@interface HealthCareTDetail : NSObject

@property (nonatomic, retain) NSDictionary* arrival_stop;
@property (nonatomic, retain) NSDictionary* arrival_time;
@property (nonatomic, retain) NSDictionary* departure_stop;
@property (nonatomic, retain) NSDictionary* departure_time;
@property (nonatomic, retain) NSString* headsign;
@property (nonatomic, retain) NSString* headway;
@property (nonatomic, retain) NSString* num_stops;
@property (nonatomic, retain) HealthCareStepLine* line;

@end

