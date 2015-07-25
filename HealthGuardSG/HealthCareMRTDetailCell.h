//
//  HealthCareMRTDetailCell.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HealthCareMRTDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *startstation_name;
@property (weak, nonatomic) IBOutlet UILabel *html_instructions;
@property (weak, nonatomic) IBOutlet UILabel *stops_mins;
@property (weak, nonatomic) IBOutlet UILabel *endstation_name;
@property (weak, nonatomic) IBOutlet UIImageView *mrtline_image;

@end
