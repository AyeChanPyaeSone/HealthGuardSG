//
//  EventsViewController.m
//  HealthGuardSG
//
//  Created by Kyaw Myint Thein on 7/26/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "EventsViewController.h"
#import "EventTableViewCell.h"
@interface EventsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *eventTableView;
@property (strong, nonatomic) NSArray *sectionOneArray;
@property (strong, nonatomic) NSArray *sectionTwoArray;
@property (strong, nonatomic) NSArray *sectionThreeArray;
@property (strong, nonatomic) NSArray *sectionOneDetailArray;
@property (strong, nonatomic) NSArray *sectionTwoDetailArray;
@property (strong, nonatomic) NSArray *sectionThreeDetailArray;

@property (strong, nonatomic) NSArray *sectionOneStartDateArray;
@property (strong, nonatomic) NSArray *sectionTwoStartDateArray;
@property (strong, nonatomic) NSArray *sectionThreeStartDateArray;

@property (strong, nonatomic) NSArray *sectionOneEndDateArray;
@property (strong, nonatomic) NSArray *sectionTwoEndDateArray;
@property (strong, nonatomic) NSArray *sectionThreeEndDateArray;
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Health Events";
    
    _sectionOneArray = @[@"Free Chest Screening for Senior Citizens in West Area"];
    
    _sectionTwoArray = @[@"Ocean Health Warehouse SALE"];
    
    _sectionThreeArray = @[@"Singapore Red Cross Sunday Sales 26 Jul 2015"];
    
    _sectionOneDetailArray = @[@"A group of volunteer doctors are gathering at Jurong Green Community Club on the second weekend of August to run a free chest screening service for senior citizens for whole 2 days."];
    _sectionTwoDetailArray = @[@"Ocean Health will be having a Warehouse SALE with discounts of up to 70% off from 29 July to 31 July 2015."];
    _sectionThreeDetailArray = @[@"Red Cross Home for the Disabled is a residential home for those with multiple disabilities, and operates a Day Activity Centre providing day care services. FoodAid is a programme where Red Cross provide monthly rations of nutritious food to the disadvantaged in Singapore."];

    _sectionOneStartDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];
    
     _sectionTwoStartDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];
    
     _sectionThreeStartDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];

    
    _sectionOneEndDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];
    
    _sectionTwoEndDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];
    
    _sectionThreeEndDateArray = @[@"22 / 2/ 2015", @"22 / 2/ 2015", @"22 / 2/ 2015"];

    _eventTableView.dataSource = self;
    _eventTableView.delegate = self;
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

-(void) loadEvents{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section)
    {
        case 0:
            return _sectionOneArray.count;
            break;
        case 1:
            return _sectionTwoArray.count;
            break;
        default:
            return _sectionThreeArray.count;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"28/07/2015 9:30";
            break;
        case 1:
            sectionName = @"08/08/2015 9:00";
            break;
        default:
            sectionName =  @"28/06/2015 5:30";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    NSString *CellIdentifier =@"eventTableCell";
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section)
    {
        case 0:
            cell.title.text = _sectionOneArray[indexPath.row];
            cell.contentText.text = _sectionOneDetailArray[indexPath.row];
            cell.startDate.text = _sectionOneStartDateArray[indexPath.row];
            cell.endDate.text = _sectionOneEndDateArray[indexPath.row];
            break;
        case 1:
            cell.title.text = _sectionTwoArray[indexPath.row];
            cell.contentText.text = _sectionOneDetailArray[indexPath.row];
            cell.startDate.text = _sectionTwoStartDateArray[indexPath.row];
            cell.endDate.text = _sectionTwoEndDateArray[indexPath.row];
        case 2:
            cell.title.text = _sectionThreeArray[indexPath.row];
            cell.contentText.text = _sectionTwoDetailArray[indexPath.row];
            cell.startDate.text = _sectionThreeStartDateArray[indexPath.row];
            cell.endDate.text = _sectionThreeEndDateArray[indexPath.row];

            break;
        default:
            break;
    }
    cell.title.lineBreakMode = UILineBreakModeWordWrap;
    cell.title.numberOfLines = 0;
    [cell.title sizeToFit];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150; // your dynamic height...
}
@end
