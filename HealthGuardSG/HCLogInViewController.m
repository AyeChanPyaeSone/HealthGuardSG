//
//  HCLogInViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "HCLogInViewController.h"
#import "ViewController.h"
#import "HCAPI.h"

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

    [HCAPI Userregister:self.email.text name:self.name.text success:^(id obj) {
        NSLog(@"Success %@",obj);
        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *healthCareemergencyVC = [mainSb instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: healthCareemergencyVC];
        [self presentViewController:navController animated:nil completion:nil];
    } fail:^(NSError *error) {
        NSLog(@"Error %@",error);
    }];

}
@end

