//
//  HCAPI.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "HCLocationPlaceParams.h"

typedef void (^SuccessBlock)(id obj);
typedef void (^FailBlock)(NSError *error);
typedef void (^ProgressBlock)(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead);

@interface HCAPI : NSObject

+(void)getNearestHClocation:(HCLocationPlaceParams*)HClocationParams success:(SuccessBlock)success fail:(FailBlock)fail;
+(void)getNearestAllHClocation:(SuccessBlock)success fail:(FailBlock)fail;

@end

