//
//  HCLogInViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "HCLogInViewController.h"
#import "ViewController.h"

@interface HCLogInViewController ()


@end

@implementation HCLogInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.delegate = self;
    self.email.delegate = self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:true];
    
    return YES;
}


- (IBAction)pressedLogin:(id)sender {
    
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *healthCareemergencyVC = [mainSb instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:healthCareemergencyVC animated:YES];
    
}
@end

