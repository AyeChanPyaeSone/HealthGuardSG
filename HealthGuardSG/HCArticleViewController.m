//
//  HCArticleViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "HCArticleViewController.h"
#import "HCArticleCell.h"
#import "HMSegmentedControl.h"

@interface HCArticleViewController ()
@property (nonatomic) NSArray *namesArray;
@property (nonatomic) NSArray *photoNameArray;

@end

@implementation HCArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    
    // Minimum code required to use the segmented control with the default styling.
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Articles",@"Top Articles", @"Recent History"]];
    segmentedControl.frame = CGRectMake(0, 63, viewWidth, 40);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:43/255.0 green:120/255.0 blue:217/255.0 alpha:1]};
    segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:43/255.0 green:120/255.0 blue:217/255.0 alpha:1];
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp;
    [self.view addSubview:segmentedControl];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCArticleCell" forIndexPath:indexPath];
    cell.authorName.text = @"AFP Relax";
    cell.articleTitle.text = @"Shooter game 'Devil's Third' launching for Wii U";
    cell.postedDate.text = @"20 July 2015";
    // cell.articleImage.image = [UIImage imageNamed:@"articleImage.jpg"];
    cell.articleShortDescription.text =@"Nintendo has announced that the third-person action shooter Devils Third is to launch in retail locations and the Nintendo eShop in the fourth quarter of 2015, with a PC version also set for release";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    ActivityDetailViewController *activityVC = [mainSb instantiateViewControllerWithIdentifier:@"ActivityDetailView"];
    //    if (indexPath.row <= self.localActivities.count) {
    //        activityVC.selectedActivity = self.localActivities[indexPath.row];
    //
    //        [self.navigationController pushViewController:activityVC animated:YES];
    //        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    }
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}
@end
