//
//  DoctorDetailViewController.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorDetailViewController.h"
#import "BannerView.h"
#import "FundView.h"
#import "DoctorFocusView.h"

@interface DoctorDetailViewController ()
@property (strong, nonatomic) IBOutlet BannerView *bannerView;
@property (strong, nonatomic) IBOutlet FundView *fundView;
@property (strong, nonatomic) IBOutlet DoctorFocusView *doctorFocusView;

@end

@implementation DoctorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerView.doctor = self.doctor;
    self.fundView.fund = self.doctor.fund;
    self.doctorFocusView.doctor = self.doctor;
}

@end
