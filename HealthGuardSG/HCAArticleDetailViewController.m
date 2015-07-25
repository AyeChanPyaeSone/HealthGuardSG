//
//  HCAArticleDetailViewController.m
//  HealthGuardSG
//
//  Created by AyeChan PyaeSone on 26/7/15.
//  Copyright (c) 2015 Tware. All rights reserved.
//

#import "HCAArticleDetailViewController.h"


@interface HCAArticleDetailViewController ()

@end

@implementation HCAArticleDetailViewController
NSMutableArray *articlesarray;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Close"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(closeTapped:)];
    self.navigationItem.rightBarButtonItem = closeButton;

    
    self.articlenamesArray = @[@"A Way to Reduce Outpatient Cost for Chronic Disease", @"Understanding people living with HIV can help save lives", @"Eat Well, Live Well", @"Impact of Haze on Health", @"Getting the Fats Right!"];
    
    self.articledescriptionsArray = @[@"The treatment for chronic diseases is costly when administered collectively over a long period. As part of the national effort to improve the management of chronic diseases, Medisave use for Chronic Disease Management Programme (CDMP) was introduced by the Ministry of Health. It aims to improve the level of care and to reduce the out-of-pocket healthcare cost for persons with chronic diseases when they seek medical treatment in the outpatient setting. With effect from 1 January 2014, the use of Medisave for CDMP is applicable for the following fifteen medical conditions: Diabetes Hypertension (High Blood Pressure) Lipid Disorders (High Blood Cholesterol) Stroke Asthma Chronic Obstructive Pulmonary Disease (COPD) Major Depression Schizophrenia Dementia Bipolar Disorder Osteoarthritis Benign Prostatic Hyperplasia Anxiety Parkinson’s Disease Nephritis/ Nephrosis Use of Medisave You can now use Medisave at participating clinics to pay for part of your outpatient treatment medical bills for the above chronic conditions. Medisave can be used for: Medical consultations if you have been diagnosed with one of the identified chronic conditions under the CDMP and/or its complications. Relevant investigations (including laboratory and radiological procedures such as X-rays) for the evaluation of the identified chronic conditions and/or its complications. Medications for the management of the identified conditions and/or their complications. Allied Health services such as nursing, physiotherapy, occupational therapy, speech therapy, dietician and podiatry services as referred by your doctor. Three safeguards have been put in place under the Medisave for Chronic Disease Management Programme. Co-payment: A co-payment of 15 per cent on each out-patient bill. Annual withdrawal limit: An annual withdrawal limit of $400 per Medisave account"];
                                      
    
    self.articlephotoNameArray = @[@"reduce", @"understanding", @"eatwell", @"impactHaze", @"gettingfats"];
    
    NSLog(@"Selected Index %ld",(long)self.selectedindex);
    
    NSString *photoName = self.articlephotoNameArray[self.selectedindex];
    
    self.articletitle.text = self.articlenamesArray[self.selectedindex];
    self.articleDescription.text = self.articledescriptionsArray[0];
    self.articleImageView.image = [UIImage imageNamed:photoName];
    
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed:)];
    
    // Do any additional setup after loading the view.
}

-(void)closeTapped:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
