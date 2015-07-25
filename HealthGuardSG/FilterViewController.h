//
//  FilterViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 26/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *clinic_switch;
- (IBAction)pressedClinic:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *drugstore_switch;
- (IBAction)presseddrugtStore:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *nursingHome_switch;
- (IBAction)pressednursingHome:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *lab_switch;
@property (weak, nonatomic) IBOutlet UISwitch *hospital_switch;
- (IBAction)pressed_lab:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *pressed_hospital;
@property (weak, nonatomic) IBOutlet UIButton *close;
- (IBAction)closepressed:(id)sender;
+(void)assignValues:(NSString *) lat lng:(NSString *) lng radius:(NSString *) radius;

@end
