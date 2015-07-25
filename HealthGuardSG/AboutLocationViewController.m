//
//  AboutLocationViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "AboutLocationViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "HCLocationPlace.h"
@interface AboutLocationViewController ()

@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIImageView *placeLogo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *address;
@end

@implementation AboutLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _placeLogo.layer.cornerRadius = _placeLogo.frame.size.width / 2;
    _placeLogo.layer.masksToBounds = YES;
    _name.text = _place.name;
    NSLog(@" _place.phone_number %@",_place.phone);
    _phone.text = _place.phone;
    _address.text = _place.address;
    
    _phone.lineBreakMode = UILineBreakModeWordWrap;
    _phone.numberOfLines = 0;
    [_phone sizeToFit];

    _name.lineBreakMode = UILineBreakModeWordWrap;
    _name.numberOfLines = 0;
    [_name sizeToFit];

    
    _address.lineBreakMode = UILineBreakModeWordWrap;
    _address.numberOfLines = 0;
    [_address sizeToFit];
//    self.description.text = _place.description;
//    _email = _place.email.
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressCallButton:(id)sender {
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end