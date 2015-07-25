//
//  Article.h
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (weak, nonatomic) IBOutlet NSString *authorName;
@property (weak, nonatomic) IBOutlet NSString *postedDate;
@property (weak, nonatomic) IBOutlet NSString *articleTitle;
@property (weak, nonatomic) IBOutlet NSString *articleImage;
@property (weak, nonatomic) IBOutlet NSString *articleShortDescription;

@end

