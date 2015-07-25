//
//  HealthCareBusDetailCell.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HealthCareBusDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *html_instructions;
@property (weak, nonatomic) IBOutlet UILabel *startbustop_name;
@property (weak, nonatomic) IBOutlet UILabel *endbustop_name;
@property (weak, nonatomic) IBOutlet UILabel *stops_time;
@property (weak, nonatomic) IBOutlet UILabel *bus_number;
@property (strong, nonatomic) IBOutlet UIImageView *busLogo;


@end
