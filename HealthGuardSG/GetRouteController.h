//
//  GetRouteController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <AFNetworking.h>
#import "HealthCareSteps.h"
@import GoogleMaps;


typedef enum tagTravelMode
{
    TravelModeDriving,
    TravelModeBicycling,
    TravelModeTransit,
    TravelModeWalking
}TravelMode;


typedef void (^Success)(NSArray *array);
typedef void (^FailBlock)(NSError *error);
typedef void (^ProgressBlock)(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead);

@interface GetRouteController : NSObject

+ (void)drawPolylineWithcoordinates:(NSArray *)locations travelMode:(TravelMode)travelMode success:(Success)success fail:(FailBlock)fail;

@end
