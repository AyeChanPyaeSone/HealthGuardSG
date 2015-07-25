//
//  HealthCareWalkDetailCell.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HealthCareWalkDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *html_instructions_label;
@property (weak, nonatomic) IBOutlet UILabel *distance_time_label;
@property (weak, nonatomic) IBOutlet UILabel *your_locations;
@property (strong, nonatomic) IBOutlet UIImageView *walkingLogo;


@end

