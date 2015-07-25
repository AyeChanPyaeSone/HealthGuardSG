//
//  EmergencyTableCell.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmergencyTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *emergencyImageView;
@property (weak, nonatomic) IBOutlet UILabel *emergencyTitle;
@property (weak, nonatomic) IBOutlet UIButton *emergencyCallButton;
@end