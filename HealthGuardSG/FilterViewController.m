//
//  FilterViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 26/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "FilterViewController.h"
#import "HealthCareMapViewController.h"
#import "HCAPI.h"

@implementation FilterViewController
NSMutableArray *typeids;
NSString *filterlat;
NSString *filterlng;
NSString *filterrad;

NSString *typestring;

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
    typestring = [typeids componentsJoinedByString:@","];
    
    NSLog(@"Result %@",typestring);
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"%@",typestring);
    NSLog(@"lat %@",filterlat);
    NSLog(@"lat %@",filterlng);
    
    
    [HCAPI filterMap:typestring lat:filterlat lng:filterlng radius:filterrad success:^(id obj) {
        NSLog(@"Success %@",obj);
        
    } fail:^(NSError *error) {
        NSLog(@"Error %@",error);
    }];
    
    
 
    
}

- (IBAction)pressedClinic:(id)sender {
}
- (IBAction)presseddrugtStore:(id)sender {
}
- (IBAction)pressednursingHome:(id)sender {
}
- (IBAction)pressed_lab:(id)sender {
}
+(void)assignValues:(NSString *) lat lng:(NSString *) lng radius:(NSString *) radius{
    filterlat = lat;
    filterlng = lng;
    filterrad = radius;
}
@end
