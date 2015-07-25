//
//  HCAArticleDetailViewController.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 26/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCAArticleDetailViewController : UIViewController

@property (assign) NSInteger selectedindex;
@property (nonatomic) NSArray *articlenamesArray;
@property (nonatomic) NSArray *articledescriptionsArray;
@property (nonatomic) NSArray *articlephotoNameArray;

@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UITextView *articleDescription;
@property (weak, nonatomic) IBOutlet UILabel *articletitle;

@end