//
//  GetRouteController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//


#define kHealthCareDirectionsURL @"https://maps.googleapis.com/maps/api/directions/json?"


#import "GetRouteController.h"
#import "RMMapper.h"
#import "HealthCareSteps.h"

@interface GetRouteController()
@end


@implementation GetRouteController
static AFHTTPRequestOperationManager* requestManager;

+(AFHTTPRequestOperationManager*)sharedRequestManager {
    return [GetRouteController sharedRequestManagerWithFormData:NO];
}

//because we can't send PUT JSON to server
//we have to send data-form format manager
//bug on 27/10/14
+(AFHTTPRequestOperationManager*)sharedRequestManagerWithFormData:(BOOL)isFormData {
    if (!requestManager) {
        NSURL* url;
        url = [NSURL URLWithString:kHealthCareDirectionsURL];
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

+ (void)drawPolylineWithcoordinates:(NSArray *)locations travelMode:(TravelMode)travelMode success:(Success)success fail:(FailBlock)fail{
    AFHTTPRequestOperationManager* manager = [GetRouteController sharedRequestManager];
    
    NSUInteger locationsCount = [locations count];
    
    if (locationsCount < 2)
        return;
    
    NSMutableArray *locationStrings = [NSMutableArray new];
    
    for (CLLocation *location in locations)
    {
        [locationStrings addObject:[[NSString alloc] initWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude]];
    }
    
    NSString *sensor = @"false";
    NSString *origin = [locationStrings objectAtIndex:0];
    NSString *destination = [locationStrings lastObject];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@origin=%@&destination=%@&sensor=%@", kHealthCareDirectionsURL, origin, destination, sensor];
    
    if (locationsCount > 2)
    {
        [url appendString:@"&waypoints=optimize:false"];
        for (int i = 1; i < [locationStrings count] - 1; i++)
        {
            [url appendFormat:@"|%@", [locationStrings objectAtIndex:i]];
        }
    }
    
    switch (travelMode)
    {
        case TravelModeWalking:
            [url appendString:@"&mode=walking"];
            break;
        case TravelModeBicycling:
            [url appendString:@"&mode=bicycling"];
            break;
        case TravelModeTransit:
            [url appendString:@"&mode=transit"];
            break;
        default:
            [url appendString:@"&mode=driving"];
            break;
    }
    
    [url appendString:@"&key=AIzaSyCW4zNkd9j2hysSQOAfU-SElISmBzcJr7E"];
    
    url = [NSMutableString stringWithString:[url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSLog(@"url %@",url);
    
    [manager GET:url  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ((success)) {
            NSLog(@"responseobject %@",responseObject);
            NSArray *routesArray = [responseObject objectForKey:@"routes"];
            if(!routesArray || !routesArray.count){
                return;
            }else{
                NSLog(@"routesArray %@",routesArray);
                NSDictionary *steps =  [routesArray objectAtIndex:0];
                NSArray *arraysteps = [steps objectForKey:@"legs"];
                NSDictionary *dictsteps = [arraysteps objectAtIndex:0];
                
                // Steps* step = [RMMapper objectWithClass:[Steps class] fromDictionary:dictsteps[@"steps"]];
                
                NSArray* stepsArray= [RMMapper arrayOfClass:[HealthCareSteps class] fromArrayOfDictionary:dictsteps[@"steps"]];
                
                if (success) {
                    success(stepsArray);
                }
                
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401) {
            // [[self appDelegate] logout];
        }else{
            if (fail) {
                fail(error);
            }
        }
    }];
}

@end
