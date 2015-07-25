//
//  HealthCareEmergencyViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "HealthCareEmergencyViewController.h"
#import "EmergencyTableCell.h"

@interface HealthCareEmergencyViewController ()
@property (nonatomic) NSArray *emergencynamesArray;
@property (nonatomic) NSArray *emergencyphotoArray;
@property (nonatomic) NSArray *emergencyPhoneArray;
@end

@implementation HealthCareEmergencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"Emergency List";
    
    self.emergencynamesArray = @[@"St Lukes Hospital", @"Khoo Teck Puat Hospital", @"Tan Tock Seng Hospital", @"Woodbridge Hospital", @"National Cancer Centre Singapore", @"Mount Elizabeth Hospital", @"National University Hospital", @"Singapore General Hospital", @"Mount Alvernia Hospital", @"Radlink Diagnostic Imaging Pte Ltd", @"Singapore National Eye Centre", @"Parkway East Hospital", @"Novena Surgery at Novena Medical Center",@"KK Women's and Children's Hospital",@"Changi General Hospital",@"Singapore Emergency Medical Care Training and Services",@"Raffles Hospital",@"Fortis Surgical Hospital",@"National Neuroscience Institue",@"Trinity House Call",@"Alexandra Hospital",@"EMERGENCY AMBULANCE AND FIRE",@"POLICE EMERGENCY",@"DENGUE HOTLINE",@"FIRE HAZARD REPORTING",@"POLICE HOTLINE",@"AVA HOTLINE",@"DRUGS & POISON"];
    
    self.emergencyPhoneArray = @[@"65632281",@"65558000",@"62566011",@" 62566011",@"63892000",
@"64368000",@"67372666",@"67372666",@"67372666",@"67372666",@"67795555",@"62223322",@"63476688",@"68360808",@"63447588",@"62255554",@"67888833",@"61001989",@"63111111",@"64737222",@"69333733",@"63577153",@"82234999",@"64722000",@"995",@"999",@"18009336483",@"18002800000",@"18002550000",@"18002262250",@"64239119"];
    
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.emergencynamesArray count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmergencyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmergencyTableCell" forIndexPath:indexPath];
  

    cell.emergencyTitle.text = self.emergencynamesArray[indexPath.row];
    cell.emergencyTitle.lineBreakMode = NSLineBreakByWordWrapping;
    cell.emergencyTitle.numberOfLines = 0;
    
   // NSString *imageName = [NSString stringWithFormat:@"%ld",[indexPath row] + 1];
   // cell.emergencyImageView.image = [UIImage imageNamed:imageName];
    [cell.emergencyCallButton addTarget:self action:@selector(pressedCallbutton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)pressedCallbutton:(UIButton *) callButton{
    
    UIView *view = callButton;
    while (![view isKindOfClass:[UITableViewCell class]]) {
        view = [view superview];
    }
    NSIndexPath *indexPath =[self.tableView indexPathForCell:(UITableViewCell *)view];
    NSLog(@"index %ld",(long)indexPath.row);
    
    NSString *phoneNumber = self.emergencyPhoneArray[indexPath.row];
    
    NSString *URLString;
    URLString = [@"tel://" stringByAppendingString:phoneNumber];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    [[UIApplication sharedApplication] openURL:URL];
    
    
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

@end
