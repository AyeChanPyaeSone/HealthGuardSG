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
#import "LockBox.h"

@implementation HCAPI

#pragma mark - Mrt Lines
static NSString* const HCLocationbyRadius = @"home/nearest_health_services";
static NSString* const HClocationPlacesALL = @"health_care_places";
static NSString* const HCregister = @"auth/register";
static NSString* const HCfilterMap = @"home/nearest_health_services_by_type";

#pragma mark - Other URLs
static NSString* const eHClocalUrl = @"http://localhost:3000/v1";
static NSString* const eHCProductionUrl = @"http://healthguardsg.cloudapp.net/v1";

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
        url = [NSURL URLWithString:eHCProductionUrl];
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
    
    // Refresh requestManager everytime it is accessed
    NSString* email = [Lockbox stringForKey:HCIEmail];
    if (email) {
        [requestManager.requestSerializer setValue:email forHTTPHeaderField:@"email"];
    } else {
        [requestManager.requestSerializer setValue:nil forHTTPHeaderField:@"email"];
    }
    
    NSLog(@"Access Token: %@", email);

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
            NSArray* arr = [RMMapper arrayOfClass:[HCLocationPlace class] fromArrayOfDictionary:responseObject[@"health_care_services"]];
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

+(void)Userregister:(NSString*)email name:(NSString*)name success:(SuccessBlock)success fail:(FailBlock)fail;
{
    
    AFHTTPRequestOperationManager* manager = [HCAPI sharedRequestManager];
    NSDictionary *parameters = @{@"email": email , @"name":name};
    [manager POST:HCregister parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ((success)) {
            NSLog(@"RESONE %@",responseObject);
            success(responseObject);
            [HCAPI saveEmail:email];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            
            NSLog(@"err %@",error);
        }
    }];
    
}

+(void)filterMap:(NSString*)typeids lat:(NSString *)lat lng:(NSString *)lng radius:(NSString *)radius success:(SuccessBlock)success fail:(FailBlock)fail;
{
    
    AFHTTPRequestOperationManager* manager = [HCAPI sharedRequestManager];
    NSDictionary *parameters = @{@"type_id": typeids,@"lat": lat,@"lng": lng,@"radius": radius};
    [manager GET:HCfilterMap parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ((success)) {
            NSLog(@"RESONE %@",responseObject);
            success(responseObject);
    }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            
            NSLog(@"err %@",error);
        }
    }];
    
}


+(void)saveEmail:(NSString *)email{
    
    if (email) {
        [Lockbox setString:email forKey:HCIEmail];
    }
    else{
          [Lockbox setString:nil forKey:HCIEmail];
    }
}

@end