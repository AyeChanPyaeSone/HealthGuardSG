//
//  HCLocationPlaceParams.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface HCLocationPlaceParams : NSObject
@property (strong,nonatomic) NSString *radius;
@property (strong,nonatomic) NSNumber *lat;
@property (strong,nonatomic) NSNumber *lng;

@end
