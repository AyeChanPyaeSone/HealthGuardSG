//
//  RouteDetailTableViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteDetailTableViewController: UITableViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) NSArray *steps;
@end
