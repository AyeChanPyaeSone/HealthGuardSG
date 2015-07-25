//
//  FilterViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 26/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "FilterViewController.h"

@implementation FilterViewController
NSMutableArray *typeids;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clinic_switch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.drugstore_switch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.nursingHome_switch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.lab_switch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.hospital_switch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    typeids = [[NSMutableArray alloc]init];
}

- (IBAction)closepressed:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    if(self.clinic_switch.on == YES){
         NSLog(@"types ids %d",true);
        [typeids addObject:@"4"];
    }
    if(self.drugstore_switch.on == YES){
         NSLog(@"types ids %d",true);
        [typeids addObject:@"5"];
    }
    if(self.nursingHome_switch.on == YES){
         NSLog(@"types ids %d",true);
        [typeids addObject:@"1"];
    }
    if(self.lab_switch.on == YES){
         NSLog(@"types ids %d",true);
        [typeids addObject:@"2"];
    }
    if(self.hospital_switch.on == YES){
         NSLog(@"types ids %d",true);
        [typeids addObject:@"3"];
    }
    NSLog(@"types ids %@",typeids);
    NSString * result = [typeids componentsJoinedByString:@","];
    
    NSLog(@"Result %@",result);
    
}
- (IBAction)pressedClinic:(id)sender {
}
- (IBAction)presseddrugtStore:(id)sender {
}
- (IBAction)pressednursingHome:(id)sender {
}
- (IBAction)pressed_lab:(id)sender {
}
@end
