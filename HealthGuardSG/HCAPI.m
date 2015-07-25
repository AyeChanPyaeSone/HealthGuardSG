//
//  HCAPI.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCAPI.h"
#import <AFNetworking.h>
#import "HCLocationPlace.h"
#import "HCLocationPlaceParams.h"
#import "RMMapper.h"

@implementation HCAPI

#pragma mark - Mrt Lines
static NSString* const HCLocationbyRadius = @"health_care_places/near_by";
static NSString* const HClocationPlacesALL = @"health_care_places";
#pragma mark - Other URLs
static NSString* const eHClocalUrl = @"http://localhost:3000";
static NSString* const eHCProductionUrl = @"http://localhost:3000/api/v1";

#pragma mark - Setup AFHTTPRequestOperationManager
static AFHTTPRequestOperationManager* requestManager;

+(AFHTTPRequestOperationManager*)sharedRequestManager {
    return [HCAPI sharedRequestManagerWithFormData:NO];
}

//because we can't send PUT JSON to server
//we have to send data-form format manager
//bug on 27/10/14
+(AFHTTPRequestOperationManager*)sharedRequestManagerWithFormData:(BOOL)isFormData {
    if (!requestManager) {
        NSURL* url;
        url = [NSURL URLWithString:eHClocalUrl];
        requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        
        //use different serializer for different format send: JSON or data-form format
        if (isFormData) {
            requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
        } else {
            requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        [requestManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        requestManager.securityPolicy.allowInvalidCertificates = NO;
        
    }

    return requestManager;
}



+(void)getNearestHClocation:(HCLocationPlaceParams*)HClocationParams success:(SuccessBlock)success fail:(FailBlock)fail {
    AFHTTPRequestOperationManager* manager = [HCAPI sharedRequestManager];
    NSDictionary *params = @{
                             @"lat":HClocationParams.lat,
                             @"lng":HClocationParams.lng,
                             @"radius":HClocationParams.radius,
                             };
    [manager POST:HCLocationbyRadius parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ((success)) {
            NSArray* arr = [RMMapper arrayOfClass:[HCLocationPlace class] fromArrayOfDictionary:responseObject];
            NSLog(@"RESONE %@",responseObject);
            success(arr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            
            NSLog(@"err %@",error);
        }
    }];
}

+(void)getNearestAllHClocation:(SuccessBlock)success fail:(FailBlock)fail{
    
    AFHTTPRequestOperationManager* manager = [HCAPI sharedRequestManager];
    [manager GET:HClocationPlacesALL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ((success)) {
            NSArray* arr = [RMMapper arrayOfClass:[HCLocationPlace class] fromArrayOfDictionary:responseObject];
            NSLog(@"RESONE %@",responseObject);
            success(arr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            
            NSLog(@"err %@",error);
        }
    }];
}

@end