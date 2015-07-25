//
//  ViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 25/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "ViewController.h"
#import "HealthCareEmergencyViewController.h"
#import "HealthCareMapViewController.h"
#import "HCArticleViewController.h"

@interface ViewController ()

@property (nonatomic) NSArray *menuArray;
@property (nonatomic) NSArray *backgroundPhotoNameArray;
@property (nonatomic) NSArray *photoNameArray;

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"HomeMenuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"HealthGuardSG";
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@""
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(flipView:)];
    flipButton.image = [UIImage imageNamed:@"Jingle Bell Filled-25.png"];
    self.navigationItem.rightBarButtonItem = flipButton;
    [flipButton init];
    
    
    self.menuArray = @[@"Map", @"Find Drug", @"Emegency Call", @"Events & promotion", @"Signup", @"Articles"];
    self.backgroundPhotoNameArray = @[@"mood1.jpg", @"mood2.jpg", @"mood3.jpg", @"mood4.jpg", @"mood5.jpg", @"mood6.jpg", @"mood7.jpg", @"mood8.jpg"];
    self.photoNameArray = @[@"stethoscope_filled-50.png", @"pill_filled-50.png", @"ambulance_filled-50.png", @"Google Blog Search Filled-50.png",@"checked_user_filled-50.png",@"New Filled-50.png"];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeMenuCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.homeMenuTitle.text = self.menuArray[indexPath.row];
    cell.homeMenubackgroundImage.image = [UIImage imageNamed: self.backgroundPhotoNameArray[indexPath.row]];
    cell.homeMenuImageView.image = [UIImage imageNamed: self.photoNameArray[indexPath.row]];
    cell.homeMenuImageView.image = [cell.homeMenuImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.homeMenuImageView setTintColor:[UIColor whiteColor]];
    
    NSLog(@"MENU %@",self.menuArray[indexPath.row]);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenSize = self.collectionView.bounds;
    CGFloat screenWidth = screenSize.size.width;
    CGFloat screenHeight = screenSize.size.height;
    
    
    CGFloat width = (screenWidth-10)/2;
    CGFloat height = (screenHeight-100)/3;
    
    NSLog(@"Width %f",width);
    
    
    return CGSizeMake(width, height);
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"IndexPath %ld",(long)indexPath.row);
    if(indexPath.row == 2){
        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HealthCareEmergencyViewController *healthCareemergencyVC = [mainSb instantiateViewControllerWithIdentifier:@"HealthCareEmergencyViewController"];
        [self.navigationController pushViewController:healthCareemergencyVC animated:YES];
    }
    else if(indexPath.row == 0){
        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HealthCareMapViewController *healthCareemergencyVC = [mainSb instantiateViewControllerWithIdentifier:@"HealthCareMapViewController"];
        [self.navigationController pushViewController:healthCareemergencyVC animated:YES];
    }
    else if(indexPath.row ==5){
        
        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HCArticleViewController *healthCareemergencyVC = [mainSb instantiateViewControllerWithIdentifier:@"HCArticleViewController"];
        [self.navigationController pushViewController:healthCareemergencyVC animated:YES];
    }
}

@end
