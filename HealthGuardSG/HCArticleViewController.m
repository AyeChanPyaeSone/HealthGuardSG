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
@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *titleArray;
@property (nonatomic) NSArray *shortDescriptionsArray;
@property (nonatomic) NSArray *datesArray;


@end

@implementation HCArticleViewController

HMSegmentedControl *segmentedControl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    
    // Minimum code required to use the segmented control with the default styling.
    segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Articles",@"Top Articles", @"Recent History"]];
    segmentedControl.frame = CGRectMake(0, 63, viewWidth, 40);
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:43/255.0 green:120/255.0 blue:217/255.0 alpha:1]};
    segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:43/255.0 green:120/255.0 blue:217/255.0 alpha:1];
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp;
    [self.view addSubview:segmentedControl];
    

    
    self.datesArray = @[@"Monday, May 4, 2015", @"Tuesday, January 27, 2015", @"Thursday, December 13, 2012", @"Thursday, April 17, 2014", @"Wednesday, April 15, 2015"];
    
    self.categoryArray = @[@"Chronic Diseases", @"Sexual Health", @"Chronic Diseases", @"Healthy Living", @"Food For Health"];
    
    self.namesArray = @[@"A Way to Reduce Outpatient Cost for Chronic Disease", @"Understanding people living with HIV can help save lives", @"Eat Well, Live Well", @"Impact of Haze on Health", @"Getting the Fats Right!"];
    
    self.photoNameArray = @[@"reduce", @"understanding", @"eatwell", @"impactHaze", @"gettingfats"];
    
    self.shortDescriptionsArray = @[@"The treatment for chronic diseases is costly when administered collectively over a long period. As part of the national effort to improve the management of chronic diseases, Medisave use for Chronic Disease Management Programme (CDMP) was introduced by the Ministry of Health.", @"I will never forget what happened the night we broke the news,recalls Mdm Tan of the time she and her husband told their children of their HIV status", @"The smarter way to eat what you love When someone mentions healthy eating, bland, tasteless food often comes to mind, more so where diabetic diets are concerned", @"What are the key air pollutants of concern? The key air pollutants of concern include particulate matter (PM), sulphur dioxide, ozone, nitrogen dioxide and carbon monoxide. Short term exposure (i.e. continuous exposure to unhealthy daily average PSI levels over a period of a few days) to these air pollutants can cause respiratory symptoms and aggravate existing heart or lung disease.",@"Fat plays an important role in our body, functioning as an energy store, a cushion for vital organs and a transport system for fat-soluble vitamins."];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(segmentedControl.selectedSegmentIndex == 0){
        return  [self.namesArray count];
    }
    else if(segmentedControl.selectedSegmentIndex == 1){
        return 2;
    }
    else{
        return 3;
    }
    return 10;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HCArticleCell" forIndexPath:indexPath];
    cell.authorName.text = self.categoryArray[indexPath.row];
    cell.articleTitle.text = self.namesArray[indexPath.row];
    cell.postedDate.text = self.datesArray[indexPath.row];
    NSString *photoName = self.photoNameArray[indexPath.row];
    cell.articleImage.image = [UIImage imageNamed:photoName];
    cell.articleShortDescription.text =self.shortDescriptionsArray[indexPath.row];
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
    
    [self.articleTableView reloadData];
}
@end
