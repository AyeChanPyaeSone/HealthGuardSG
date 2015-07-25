//

//  HealthCareMapViewController.m

//  HealthGuardSG

//

//  Created by AyeChan PyaeSone on 25/7/15.

//  Copyright (c) 2015 Tware. All rights reserved.

//



#import "HealthCareMapViewController.h"

#import <INTULocationManager/INTULocationManager.h>

#import <SMCalloutView/SMCalloutView.h>

#import <GoogleMaps/GoogleMaps.h>

#import <QuartzCore/QuartzCore.h>

#import "Colours.h"

#import "HCAPI.h"

#import "RouteDetailTableViewController.h"

#import "GetRouteController.h"

#import "MZFormSheetPresentationController.h"

#import "HCLocationPlaceParams.h"

#import "HCLocationPlace.h"

#import "AboutLocationViewController.h"

@import CoreLocation;

@import GoogleMaps;

static const CGFloat CalloutYOffset = 50.0f;

static NSString * const TitleKey = @"title";

static NSString * const InfoKey = @"info";

static NSString * const LatitudeKey = @"latitude";

static NSString * const LongitudeKey = @"longitude";

static NSString * const ID = @"ID";

static const CLLocationDegrees DefaultLatitude = 1.3000;

static const CLLocationDegrees DefaultLongitude = 103.8000;

static const CGFloat DefaultZoom = 11.0f;



@interface HealthCareMapViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate>



@property (strong, nonatomic) IBOutlet GMSMapView *HCmapView;

@property (nonatomic, retain) CLLocationManager *HClocationManager;

@property (nonatomic, retain) CLLocation *HCcurrentLocation;

@property (strong, nonatomic) SMCalloutView *HCScrollupView;


@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;

@property (strong, nonatomic) NSMutableArray *places;

@property (strong, nonatomic) UIView *emptySCrollupView;



@end



@implementation HealthCareMapViewController

NSArray *HCSteps;

NSInteger selectedOne;

- (void)viewDidLoad {
    
    
    
    
    
    [super viewDidLoad];
    
    //    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(closeTapped:)];
    
    //    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:@selector(closeTapped:)];
    
    //
    
    _places = [[NSMutableArray alloc] init];
    
    self.title = @"Health Guard Map";
    
    [self startHCLocationManager];
    
    [self loadHCmapView];
    
    //    [self loadAllPlaces];
    
    [self loadHealthCarePlaces];
    
    // Do any additional setup after loading the view from its nib.
    
}
//
//- (IBAction)sliderTapped:(id)sender {
//    
//    [self loadHealthCarePlacesWithRadius:[NSString stringWithFormat:@"%f",_radiusSlider.value]];
//    
//}


- (IBAction)sliderTapped:(id)sender {
        [self loadHealthCarePlacesWithRadius:[NSString stringWithFormat:@"%f",_radiusSlider.value]];
    
}

-(void) startHCLocationManager{
    
    
    
    _HClocationManager = [[CLLocationManager alloc] init];
    
    _HClocationManager.delegate = self;
    
    _HClocationManager.distanceFilter = kCLDistanceFilterNone;
    
    _HClocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_HClocationManager requestWhenInUseAuthorization];
    
    [_HClocationManager requestAlwaysAuthorization];
    
    if ([_HClocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [_HClocationManager requestWhenInUseAuthorization];
        
    }
    
    [_HClocationManager startUpdatingLocation];
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    _HCcurrentLocation  = newLocation;
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    
    NSMutableArray *coordinates = [[NSMutableArray alloc]init];
    
    
    
    _HCcurrentLocation = [locations lastObject];
    
}



- (void)mapView:(GMSMapView *)pMapView didChangeCameraPosition:(GMSCameraPosition *)position {
    
    /* move callout with map drag */
    
    if (pMapView.selectedMarker != nil && !self.HCScrollupView.hidden) {
        
        CLLocationCoordinate2D anchor = [pMapView.selectedMarker position];
        
        
        
        CGPoint arrowPt = self.HCScrollupView.backgroundView.arrowPoint;
        
        
        
        CGPoint pt = [pMapView.projection pointForCoordinate:anchor];
        
        pt.x -= arrowPt.x;
        
        pt.y -= arrowPt.y + CalloutYOffset;
        
        
        
        self.HCScrollupView.frame = (CGRect) {.origin = pt, .size = self.HCScrollupView.frame.size };
        
    } else {
        
        self.HCScrollupView.hidden = YES;
        
    }
    
}







- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    self.HCScrollupView.hidden = YES;
    
}





- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    
    /* don't move map camera to center marker on tap */
    
    mapView.selectedMarker = marker;
    
    return YES;
    
}



-(void) scrollUpViewSetup{
    
    
    
    _HCScrollupView = [[SMCalloutView alloc] init];
    
    UIImageView *carView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Routeshow-50"]];
    
    
    
    if ([self.HCScrollupView.backgroundView isKindOfClass:[SMCalloutMaskedBackgroundView class]]) {
        
        
        
        // wrap it in a blue background on iOS 7+
        
        UIButton *blueView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44+30)];
        
        blueView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
        
        [blueView addTarget:self action:@selector(getHCLocationDirection:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        carView.frame = CGRectMake(11, 14, 20, 20);
        
        carView.image = [carView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        carView.tintColor = [UIColor whiteColor];
        
        [blueView addSubview:carView];
        
        
        
        self.HCScrollupView.leftAccessoryView = blueView;
        
        
        
        // create a little disclosure indicator since our callout is tappable
        
        UIButton *disclosure = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [disclosure addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getHCLocationDirection:)]];
        
        self.HCScrollupView.rightAccessoryView = disclosure;
        
        
        
    }else {
        
        // "inset" the car graphic to match the callout's title on iOS 6-
        
        carView.layer.shadowOffset = CGSizeMake(0, -1);
        
        carView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        
        carView.layer.shadowOpacity = 1;
        
        carView.layer.shadowRadius = 0;
        
        carView.clipsToBounds = NO;
        
        self.HCScrollupView.leftAccessoryView = carView;
        
    }
    
    
    
    // if we're on iOS 7+, the callout can be clicked - add a disclosure image to indicate this to the user!
    
    if ([self.HCScrollupView.backgroundView isKindOfClass:[SMCalloutMaskedBackgroundView class]]) {
        
        //        self.calloutView.rightAccessoryView =
        
        self.HCScrollupView.rightAccessoryView.alpha = 0.2;
        
        
        
        UIButton *disclosure = [UIButton buttonWithType:UIButtonTypeCustom];
        
        disclosure.frame =CGRectMake(0, 0, 44, 44);
        
        [disclosure setImage:[UIImage imageNamed:@"UITableNext@2x"] forState:UIControlStateNormal];
        
        //        disclosure.imageView.image =[UIImage imageNamed:@"UITableNext"];
        
        //        disclosure.imageView.tintColor = [UIColor orangeColor];
        
        [disclosure addTarget:self action:@selector(getLocationRoute)
         
             forControlEvents:UIControlEventTouchUpInside];
        
        self.HCScrollupView.rightAccessoryView = disclosure;
        
    }
    
    self.HCScrollupView.delegate = self;
    
    _emptySCrollupView= [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
}





- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
    CLLocationCoordinate2D anchor = marker.position;
    
    
    
    CGPoint point = [mapView.projection pointForCoordinate:anchor];
    
    
    
    self.HCScrollupView.title = marker.title;
    
    self.HCScrollupView.calloutOffset = CGPointMake(0, -CalloutYOffset);
    
    self.HCScrollupView.hidden = NO;
    
    selectedOne = [marker.userData integerValue];
    
    
    
    CGRect calloutRect = CGRectZero;
    
    calloutRect.origin = point;
    
    calloutRect.size = CGSizeZero;
    
    
    
    [self.HCScrollupView presentCalloutFromRect:calloutRect
     
                                         inView:mapView
     
                              constrainedToView:mapView
     
                                       animated:YES];
    
    
    
    return self.emptySCrollupView;
    
    
    
}





- (IBAction)getHCLocationDirection:(id)sender  {
    
    
    
    NSMutableArray *coordinates = [[NSMutableArray alloc]init];
    
    if(_HCcurrentLocation.coordinate.latitude>0.0){
        
        HCLocationPlace *selectedPlace;
        
        for (HCLocationPlace *place in _places) {
            
            if (place.id == selectedOne) {
                
                selectedPlace = place;
                
                //                        return;
                
            }
            
        }
        
        NSLog(@"selectedPlace%@",selectedPlace);
        
        
        
        if (selectedPlace) {
            
            [coordinates addObject:[[CLLocation alloc] initWithLatitude:_HCcurrentLocation.coordinate.latitude longitude:_HCcurrentLocation.coordinate.longitude]];
            
            [coordinates addObject:[[CLLocation alloc] initWithLatitude:[selectedPlace.lat doubleValue] longitude:[selectedPlace.lng doubleValue]]];
            
            [self drawPolyLine:coordinates];
            
            NSLog(@"DRAW");
            
        }
        
        
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Route"
                              
                                                        message:@"Cannot get the route detail. Please get the direction frist."
                              
                                                       delegate:self
                              
                                              cancelButtonTitle:@"OK"
                              
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
}



- (void)calloutViewClicked:(SMCalloutView *)calloutView{
    
    [self getAboutLocation];
    
    NSLog(@"calloutViewClicked");
    
}



- (void)getAboutLocation {
    
    [[MZFormSheetPresentationController appearance] setShouldApplyBackgroundBlurEffect:YES];
    
    AboutLocationViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutLocationViewController"];
    
    //    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:detailView];
    
    MZFormSheetPresentationController *formSheetController = [[MZFormSheetPresentationController alloc] initWithContentViewController:detailView];
    
    formSheetController.shouldDismissOnBackgroundViewTap= YES;
    
    
    
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideFromBottom;
    
    formSheetController.contentViewSize = CGSizeMake(self.view.frame.size.width, 450);
    
    formSheetController.view.frame =CGRectMake(0,180, self.view.frame.size.width, 450);
    
    [self presentViewController:formSheetController animated:YES completion:nil];
    
}



- (void)getLocationRoute {
    
    NSMutableArray *coordinates = [[NSMutableArray alloc]init];
    
    if(_HCcurrentLocation.coordinate.latitude>0.0){
        
        HCLocationPlace *selectedPlace;
        
        for (HCLocationPlace *place in _places) {
            
            if (place.id == selectedOne) {
                
                selectedPlace = place;
                
                //                        return;
                
            }
            
        }
        
        NSLog(@"selectedPlace%@",selectedPlace);
        
        
        
        if (selectedPlace) {
            
            [coordinates addObject:[[CLLocation alloc] initWithLatitude:_HCcurrentLocation.coordinate.latitude longitude:_HCcurrentLocation.coordinate.longitude]];
            
            [coordinates addObject:[[CLLocation alloc] initWithLatitude:[selectedPlace.lat doubleValue] longitude:[selectedPlace.lng doubleValue]]];
            
            [self drawPolyLine:coordinates];
            
            NSLog(@"DRAW");
            
        }
        
        
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Route"
                              
                                                        message:@"Cannot get the route detail. Please get the direction frist."
                              
                                                       delegate:self
                              
                                              cancelButtonTitle:@"OK"
                              
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    [[MZFormSheetPresentationController appearance] setShouldApplyBackgroundBlurEffect:YES];
    
    
    
    RouteDetailTableViewController *pinVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RouteDetailTableViewController"];
    
    pinVC.steps =  HCSteps;

    if(HCSteps.count){
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:pinVC];    MZFormSheetPresentationController *formSheetController = [[MZFormSheetPresentationController alloc] initWithContentViewController:navVC];
        
        formSheetController.shouldDismissOnBackgroundViewTap= YES;
        
        
        
        formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleSlideFromBottom;
        
        formSheetController.contentViewSize = CGSizeMake(self.view.frame.size.width, 450);
        
        formSheetController.view.frame =CGRectMake(0,300, self.view.frame.size.width, 450);
        
        [self presentViewController:formSheetController animated:YES completion:nil];
        

    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Route"
                              
                                                        message:@"Cannot get the route detail. Please get the direction frist."
                              
                                                       delegate:self
                              
                                              cancelButtonTitle:@"OK"
                              
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}



-(void) drawPolyLine:(NSMutableArray*)coordinates{
    
    self.HCScrollupView.hidden = YES;
    
    [_HCmapView clear];
    
    [self loadmarkerstomapView:_places];
    
    if ([coordinates count] > 1)
        
    {
        
        [GetRouteController drawPolylineWithcoordinates:coordinates travelMode:TravelModeTransit success:^(NSArray *arr){
            
            HCSteps = [[NSMutableArray alloc]init];
            
            HCSteps = arr;
            
            
            
            for(HealthCareSteps *step in arr){
                
                NSLog(@"STEP MODE %@",step.travel_mode);
                
                NSLog(@"STEP MODE Poly %@",step.polyline);
                
                
                
                GMSPolyline *polyline =[[GMSPolyline alloc]init];
                
                
                
                NSString *points = [step.polyline objectForKey:@"points"];
                
                GMSPath *path = [GMSPath pathFromEncodedPath:points];
                
                polyline = [GMSPolyline polylineWithPath:path];
                
                
                
                if([step.travel_mode isEqualToString:@"WALKING"]){
                    
                    polyline.strokeColor = [UIColor greenColor];
                    
                    
                    
                }
                
                else if([step.travel_mode isEqualToString:@"TRANSIT"]){
                    
                    NSLog(@"step.transit_details.line.vehicle.type %@",step.transit_details.line.vehicle.type);
                    
                    if([step.transit_details.line.vehicle.type  isEqual: @"SUBWAY"]){
                        
                        
                        
                        if([step.transit_details.line.name isEqual:@"East West Line"]){
                            
                            polyline.strokeColor = [UIColor colorWithRed:27/255.0 green:148/255.0 blue:76/255.0 alpha:1.0];
                            
                        }
                        
                        else if([step.transit_details.line.name isEqual:@"North South Line"]){
                            
                            polyline.strokeColor = [UIColor colorWithRed:210/255.0 green:51/255.0 blue:43/255.0 alpha:1.0];
                            
                        }
                        
                        else if([step.transit_details.line.name isEqual:@"North East Line"]){
                            
                            polyline.strokeColor = [UIColor colorWithRed:123/255.0 green:46/255.0 blue:127/255.0 alpha:1.0];
                            
                        }
                        
                        else if([step.transit_details.line.name isEqual:@"Circle Line"]){
                            
                            polyline.strokeColor = [UIColor colorWithRed:241/255.0 green:173/255.0 blue:63/255.0 alpha:1.0];
                            
                        }
                        
                        else if([step.transit_details.line.name isEqual:@"Downtown Line"]){
                            
                            
                            
                            polyline.strokeColor = [UIColor colorWithRed:3/255.0 green:84/255.0 blue:166/255.0 alpha:1.0];
                            
                            
                            
                        }
                        
                        else{
                            
                            polyline.strokeColor = [UIColor colorWithRed:114/255.0 green:127/255.0 blue:118/255.0 alpha:1.0];
                            
                        }
                        
                        
                        
                    }
                    
                    else{
                        
                        polyline.strokeColor =[UIColor skyBlueColor];
                        
                    }
                    
                }
                
                
                
                polyline.strokeWidth = 6;
                
                polyline.geodesic = YES;
                
                
                
                polyline.map = _HCmapView;
                
            }
            
            
            
        } fail:^(NSError *error) {
            
            NSLog(@"%@", error);
            
        }];
        
        
        
    }
    
    
    
}





-(void) loadHCmapView{
    
    
    
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:DefaultLatitude
                                         
                                                                    longitude:DefaultLongitude
                                         
                                                                         zoom:DefaultZoom];
    
    
    
    _HCmapView.camera = cameraPosition;
    
    self.HCmapView.delegate = self;
    
    _HCmapView.myLocationEnabled = YES;
    
    _HCmapView.settings.myLocationButton = YES;
    
    _HCmapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.HCmapView];
    
}







-(void) loadHealthCarePlaces{
    
    HCLocationPlaceParams *hci = [[HCLocationPlaceParams alloc] init];
    
    hci.radius = @"5";
    
    hci.lat =[NSNumber numberWithDouble:_HCcurrentLocation.coordinate.latitude ];
    
    hci.lng = [NSNumber numberWithDouble:_HCcurrentLocation.coordinate.longitude ];
    
    
    
    [HCAPI getNearestHClocation:hci success:^(id obj) {
        
        [_places removeAllObjects];
        
        [_places addObjectsFromArray:obj];
        
        NSLog(@"_places %lu",(unsigned long)_places.count);
        
        [self loadmarkerstomapView:_places];
        
    } fail:^(NSError *error) {
        
        NSLog(@"Error %@",error);
        
    }];
    
}



-(void) loadHealthCarePlacesWithRadius:(NSString*)radius{
    
    HCLocationPlaceParams *hci = [[HCLocationPlaceParams alloc] init];
    
    hci.radius = radius;
    
    hci.lat =[NSNumber numberWithDouble:_HCcurrentLocation.coordinate.latitude ];
    
    hci.lng = [NSNumber numberWithDouble:_HCcurrentLocation.coordinate.longitude ];
    
    
    
    [HCAPI getNearestHClocation:hci success:^(id obj) {
        
        NSLog(@"Success %@",obj);
        
        [_places removeAllObjects];
        
        [_places addObjectsFromArray:obj];
        
        [self loadmarkerstomapView:_places];
        
    } fail:^(NSError *error) {
        
        NSLog(@"Error %@",error);
        
    }];
    
}





- (void)loadmarkerstomapView:(NSArray*)places {
    
    [_HCmapView clear];
    
    UIImage *pinImage = [UIImage imageNamed:@"Pin"];
    
    
    
    for (HCLocationPlace *hcPlace in places) {
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        
        
        
        marker.position = CLLocationCoordinate2DMake([hcPlace.lat doubleValue], [hcPlace.lng doubleValue]);
        
        marker.title = hcPlace.name;
        
        if (hcPlace.type_id == 1) {
            
            marker.icon = [UIImage imageNamed:@"Clinic-50"];
            
        }else{
            
            marker.icon = pinImage;
            
        }
        
        
        
        marker.tappable = YES;
        
        marker.userData = [NSString stringWithFormat:@"%ld",hcPlace.id];
        
        marker.infoWindowAnchor = CGPointMake(0.5, 0.25);
        
        marker.groundAnchor = CGPointMake(0.5, 1.0);
        
        
        
        marker.map = self.HCmapView;
        
    }
    
    [self scrollUpViewSetup];
    
    
    
}



-(IBAction)closeTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    // your code
    
    NSLog(@"TOUCH");
    
}

@end