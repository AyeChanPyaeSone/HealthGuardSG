//
//  HealthCareEmergencyViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmergencyTableCell.h"

@interface HealthCareEmergencyViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *emergencyhealthcarevtableView;
@end