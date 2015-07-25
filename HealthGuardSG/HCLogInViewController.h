//
//  HCLogInViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCLogInViewController: UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)pressedLogin:(id)sender;


@end
