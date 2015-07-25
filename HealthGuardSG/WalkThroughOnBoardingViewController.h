//
//  WalkThroughOnBoardingViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "WalkThroughOnBoardingViewController.h"
#import "OnboardingViewController.h"

@interface WalkThroughOnBoardingViewController : OnboardingViewController

- (instancetype)initWithCompletionHandler:(dispatch_block_t)completionHandler;

@end

