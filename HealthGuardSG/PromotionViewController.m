//
//  PromotionViewController.m
//  HealthGuardSG
//
//  Created by Kyaw Myint Thein on 7/26/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "PromotionViewController.h"
#import "PromoTableViewCell.h"
@interface PromotionViewController ()
@property (strong, nonatomic) IBOutlet UITableView *_promoTableView;
@property (strong, nonatomic) IBOutlet NSArray *titleArray;
@property (strong, nonatomic) IBOutlet NSArray *contentArray;
@property (strong, nonatomic) IBOutlet NSArray *startDateArray;
@property (strong, nonatomic) IBOutlet NSArray *endDateArray;
@property (strong, nonatomic) IBOutlet NSArray *dateArray;
@property (strong, nonatomic) IBOutlet NSArray *locationArray;
@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"Public Health Lecture : Research Findings on Prolonged Use of Facemasks ", @"Public Health Lecture :MOH’s Role in Shaping Medical Education, Training and Assessments"];
    _contentArray = @[@"Red Cross Home for the Disabled is a residential home for those with multiple disabilities, and operates a Day Activity Centre providing day care services.FoodAid is a programme where Red Cross provide monthly rations of nutritious food to the disadvantaged in Singapore.", @"TransportAid is a service which helps the elderly and disabled from low-income homes get to and from their healthcare service facilities, such as medical treatments, rehabilitation and day activity centres."];
    _startDateArray =@[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];

    _endDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];

    _dateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];
    _locationArray = @[@"Expo", @"Changi",@"Orchard"];
    __promoTableView.dataSource = self;
    __promoTableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return _titleArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    NSString *CellIdentifier =@"promoTableViewCell";
    PromoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[PromoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.title.text = _titleArray[indexPath.row];
    cell.startDate.text = _startDateArray[indexPath.row];
    cell.location.text = _locationArray[indexPath.row];
    cell.date.text = _dateArray[indexPath.row];
    cell.endDate.text = _endDateArray[indexPath.row];
//    cell.contentText.editable = YES;
//    cell.contentText.selectable = YES;
//    cell.contentText.font = [UIFont fontWithName:@"Aileron" size:28];
    cell.contentText.text = _contentArray[indexPath.row];
//    cell.contentText.editable = NO;
    cell.title.lineBreakMode = UILineBreakModeWordWrap;
    cell.title.numberOfLines = 0;
    [cell.title sizeToFit];
    return cell;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 20; // your dynamic height...
//}

@end
