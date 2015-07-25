//
//  HealthCareSteps.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "HealthCareSteps.h"

@implementation HealthCareSteps

-(Class)rm_itemClassForArrayProperty:(NSString *)property {
    if([property isEqualToString:@"steps"]) {
        return [HealthCareDSteps class];
    }
    return nil;
}
@end
