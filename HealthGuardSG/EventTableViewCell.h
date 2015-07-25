//
//  EventTableViewCell.h
//  HealthGuardSG
//
//  Created by Kyaw Myint Thein on 7/26/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UITextView *contentText;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *endDate;

@end
