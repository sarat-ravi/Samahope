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
#import "FundCell.h"
#import "DoctorFocusCell.h"
#import "PatientCell.h"

@interface DoctorDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet BannerView *bannerView;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;

- (IBAction)onDonateButtonTapped:(id)sender;

@end

@implementation DoctorDetailViewController

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Make nav bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor darkTextColor];
    
    self.bannerView.doctor = self.doctor;
    
    // Set up table stuff
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    NSArray *cellNames = @[@"FundCell", @"DoctorFocusCell", @"PatientCell"];
    for (NSString *cellName in cellNames) {
        UINib *cellNib = [UINib nibWithNibName: cellName bundle:nil];
        [self.detailTableView registerNib:cellNib forCellReuseIdentifier: cellName];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.detailTableView reloadData];
}

#pragma mark Core

#pragma mark Table Listeners

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FundCell *cell = [self.detailTableView dequeueReusableCellWithIdentifier: @"FundCell" forIndexPath:indexPath];
        cell.fund = self.doctor.fund;
        return cell;
    } else if (indexPath.row == 1) {
        DoctorFocusCell *cell = [self.detailTableView dequeueReusableCellWithIdentifier: @"DoctorFocusCell" forIndexPath:indexPath];
        cell.doctor = self.doctor;
        return cell;
    } else {
        Patient *patient = self.doctor.patients[indexPath.row - 2];
        PatientCell *cell = [self.detailTableView dequeueReusableCellWithIdentifier: @"PatientCell" forIndexPath:indexPath];
        cell.patient = patient;
        return cell;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + [self.doctor.patients count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %ld in section %ld", (long)indexPath.row, (long)indexPath.section);
}

#pragma mark User Actions

- (IBAction)onDonateButtonTapped:(id)sender {
    NSLog(@"DetailVC: Donate button tapped");
    DonateViewController *vc = [[DonateViewController alloc] init];
    vc.doctor = self.doctor;
    [self.navigationController pushViewController: vc animated:YES];
}
@end
