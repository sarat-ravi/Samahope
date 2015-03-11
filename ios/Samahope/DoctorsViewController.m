//
//  DoctorsViewController.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorsViewController.h"
#import "DoctorDetailViewController.h"
#import "SamahopeClient.h"
#import "DoctorCell.h"
#import "SamahopeClient.h"

NSString *const kDoctorCellName = @"DoctorCell";

@interface DoctorsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *doctorsTableView;
@property (strong, nonatomic) NSArray *doctors;

@end

@implementation DoctorsViewController

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Our Doctors";
    
    self.doctorsTableView.delegate = self;
    self.doctorsTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName: kDoctorCellName bundle:nil];
    [self.doctorsTableView registerNib:cellNib forCellReuseIdentifier: kDoctorCellName];
    self.doctorsTableView.rowHeight = UITableViewAutomaticDimension;
    self.doctorsTableView.estimatedRowHeight = 100;
    
    [self refreshDoctorsData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.doctorsTableView reloadData];
}

#pragma mark Core

- (void)refreshDoctorsData {
    NSLog(@"DoctorsViewController: refreshDoctorsData");
    [[SamahopeClient sharedInstance] fetchDataWithCompletion:^(NSArray *doctors, NSError *error) {
        // Completion
        if (error) {
            NSLog(@"DoctorsViewController: Error fetching data: %@", error);
        } else {
            NSLog(@"Fetched doctors: %@", doctors);
            self.doctors = doctors;
            [self.doctorsTableView reloadData];
        }
    }];
}

#pragma mark Table View Listeners

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCell *cell = [self.doctorsTableView dequeueReusableCellWithIdentifier: kDoctorCellName forIndexPath:indexPath];
    cell.doctor = self.doctors[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Doctors count: %lu", (unsigned long)[self.doctors count]);
    return [self.doctors count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %ld in section %ld", (long)indexPath.row, (long)indexPath.section);
    [tableView deselectRowAtIndexPath: indexPath animated:NO];
    
    DoctorDetailViewController *vc = [[DoctorDetailViewController alloc] init];
    vc.doctor = self.doctors[indexPath.row];
    [self.navigationController pushViewController: vc animated:YES];
}

@end
