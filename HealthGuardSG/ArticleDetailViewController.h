//
//  ArticleDetailViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 26/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailViewController: UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)pressedLogin:(id)sender;


@end

