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
#import "DonateViewController.h"
#import "ScrollViewManager.h"

@interface DoctorDetailViewController ()

@property (strong, nonatomic) IBOutlet BannerView *bannerView;
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) ScrollViewManager *scrollViewManager;

- (IBAction)onDonateButtonTapped:(id)sender;

@end

@implementation DoctorDetailViewController

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollViewManager = [[ScrollViewManager alloc] initWithScrollView: self.contentScrollView];
    self.bannerView.doctor = self.doctor;
    [self addViewsToScrollView];
}

#pragma mark Core

- (void)addViewsToScrollView {
    // self.contentScrollView.frame = CGRectMake(0, self.contentScrollView.frame.origin.y, 320, );
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGFloat width = screenFrame.size.width;
    
    FundView *fv = [[FundView alloc] initWithFrame: CGRectMake(0, 0, width, 66)];
    DoctorFocusView *dfv = [[DoctorFocusView alloc] initWithFrame: CGRectMake(0, 0, width, 80)];
    
    NSArray *views = @[fv, fv, fv, fv, fv, fv, dfv];
    [self.scrollViewManager addViewsToScrollView: views withWidth: width];
    
    fv.fund = self.doctor.fund;
    dfv.doctor = self.doctor;
}

#pragma mark User Actions

- (IBAction)onDonateButtonTapped:(id)sender {
    NSLog(@"DetailVC: Donate button tapped");
    DonateViewController *vc = [[DonateViewController alloc] init];
    vc.doctor = self.doctor;
    [self.navigationController pushViewController: vc animated:YES];
}
@end
