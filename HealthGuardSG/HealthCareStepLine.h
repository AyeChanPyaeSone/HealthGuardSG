//
//  HealthCareStepLine.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMMapper.h"
#import "HealthCareStepVehicle.h"

@interface HealthCareStepLine : NSObject

@property (nonatomic, retain) NSDictionary* agencies;
@property (nonatomic, retain) NSString* color;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* short_name;
@property (nonatomic, retain) HealthCareStepVehicle* vehicle;

@end
