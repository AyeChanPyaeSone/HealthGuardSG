//
//  RouteDetailTableViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "RouteDetailTableViewController.h"
#import "HealthCareWalkDetailCell.h"
#import "HealthCareMRTDetailCell.h"
#import "HealthCareBusDetailCell.h"
#import "HealthCareSteps.h"
#import <ChameleonFramework/Chameleon.h>
@interface RouteDetailTableViewController ()

@end

@implementation RouteDetailTableViewController

NSMutableArray *steps;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    steps = [[NSMutableArray alloc]init];
    
    NSLog(@"Steps Count %lu",(unsigned long)[self.steps count]);
    for(HealthCareSteps *step in self.steps){
        [steps addObject:step];
    }
    
    NSLog(@" Detail Steps Count %lu",(unsigned long)[steps count]);
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed:)];
    
    // Do any additional setup after loading the view.
}
-(void)cancelPressed:(UIBarButtonItem * __unused)button
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return steps.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HealthCareSteps *step = steps[indexPath.row];
    
    if(indexPath.row==0){
        return 95;
    }
    else if([step.travel_mode  isEqual: @"WALKING"]){
        
        return 90;
    }
    else{
        return 120;
    }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HealthCareSteps *step = steps[indexPath.row];
    NSString *num_stops;
    HealthCareWalkDetailCell *walkrouteDetailCell;
    if([step.travel_mode  isEqual: @"WALKING"]){
        
        
        static NSString *cellIdentifier = @"WalkRouteDetailCell";
        HealthCareWalkDetailCell *walkrouteDetailCell = (HealthCareWalkDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        if(indexPath.row>0){
            walkrouteDetailCell.your_locations.text = step.html_instructions;
            walkrouteDetailCell.html_instructions_label.text = [NSString stringWithFormat:@"%@ ( %@ ) ",[step.distance objectForKey:@"text"],[step.duration objectForKey:@"text"]];
            walkrouteDetailCell.distance_time_label.text=@"";
            
        }
        else{
            
            walkrouteDetailCell.html_instructions_label.text = step.html_instructions;
            walkrouteDetailCell.distance_time_label.text = [NSString stringWithFormat:@"%@ ( %@ ) ",[step.distance objectForKey:@"text"],[step.duration objectForKey:@"text"]];
        }
        
        walkrouteDetailCell.backgroundColor = [UIColor clearColor];
        walkrouteDetailCell.walkingLogo.image = [walkrouteDetailCell.walkingLogo.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        walkrouteDetailCell.walkingLogo.tintColor =[UIColor flatSkyBlueColorDark];
        
        return walkrouteDetailCell;
        
    }
    else if([step.travel_mode  isEqual: @"TRANSIT"]){
        
        if([step.transit_details.line.vehicle.type  isEqual: @"SUBWAY"]){
            
            static NSString *cellIdentifier = @"MRTRouteDetailCell";
            HealthCareMRTDetailCell *mrtrouteDetailCell = (HealthCareMRTDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            if([step.transit_details.line.name isEqual:@"East West Line"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"EW"];
            }
            else if([step.transit_details.line.name isEqual:@"North South Line"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"NS"];
            }
            else if([step.transit_details.line.name isEqual:@"North East Line"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"NE"];
            }
            else if([step.transit_details.line.name isEqual:@"Circle Line"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"CC"];
            }
            else if([step.transit_details.line.name isEqual:@"Downtown Line"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"DT"];
                
            }
            else if([step.transit_details.line.name isEqual:@"Bukit Pangjang Line"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"BP"];
                
            }
            else if([step.transit_details.line.name isEqual:@"Sengkang West Loop"]){
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"SW"];
                
            }
            else{
                mrtrouteDetailCell.mrtline_image.image= [UIImage imageNamed:@"PE"];
            }
            
            mrtrouteDetailCell.html_instructions.text = step.html_instructions;
            mrtrouteDetailCell.startstation_name.text = [step.transit_details.departure_stop objectForKey:@"name"];
            mrtrouteDetailCell.endstation_name.text = [step.transit_details.arrival_stop objectForKey:@"name"];
            if([step.transit_details.num_stops intValue]>1){
                num_stops = @"stops";
            }
            else{
                num_stops = @"stop";
            }
            mrtrouteDetailCell.stops_mins.text = [NSString stringWithFormat:@"%@ %@ (%@)",step.transit_details.num_stops,num_stops,[step.duration objectForKey:@"text"]];
            mrtrouteDetailCell.backgroundColor = [UIColor clearColor];
            mrtrouteDetailCell.mrtline_image.image = [mrtrouteDetailCell.mrtline_image.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            mrtrouteDetailCell.mrtline_image.tintColor =[UIColor flatSkyBlueColorDark];
            
            return mrtrouteDetailCell;
            
        }
        else{
            static NSString *cellIdentifier = @"BusRouteDetailCell";
            HealthCareBusDetailCell *busrouteDetailCell = (HealthCareBusDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            busrouteDetailCell.html_instructions.text = step.html_instructions;
            busrouteDetailCell.startbustop_name.text = [step.transit_details.departure_stop objectForKey:@"name"];
            busrouteDetailCell.endbustop_name.text = [step.transit_details.arrival_stop objectForKey:@"name"];
            
            busrouteDetailCell.bus_number.layer.borderColor = [UIColor blackColor].CGColor;
            busrouteDetailCell.bus_number.layer.borderWidth = 1.0;
            busrouteDetailCell.bus_number.text = step.transit_details.line.short_name;
            if([step.transit_details.num_stops intValue]>1){
                num_stops = @"stops";
            }
            else{
                num_stops = @"stop";
            }
            
            busrouteDetailCell.stops_time.text = [NSString stringWithFormat:@"%@ %@ (%@)",step.transit_details.num_stops,num_stops,[step.duration objectForKey:@"text"]];
            busrouteDetailCell.backgroundColor = [UIColor clearColor];
            busrouteDetailCell.busLogo.image = [busrouteDetailCell.busLogo.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            busrouteDetailCell.busLogo.tintColor =[UIColor flatSkyBlueColorDark];
            
            return busrouteDetailCell;
            
        }
        
    }
    return walkrouteDetailCell;
}

@end
