//
//  DonateViewController.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DonateViewController.h"
#import "DonateCell.h"
//#import "PaymentViewController.h"
#import "User.h"
#import "BannerView.h"
#import "SamahopeClient.h"
#import "ThanksViewController.h"
#import "PaymentFormViewController.h"

typedef NS_ENUM(NSInteger, DonateAmountOption) {
    DonateAmountOption1 = 0,
    DonateAmountOption2,
    DonateAmountOptionCustom
};

@interface DonateViewController () <UITableViewDataSource, UITableViewDelegate, DonateCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet BannerView *bannerView;

@property (nonatomic, strong) NSArray *donateAmounts;
@property (nonatomic, assign) DonateAmountOption selectedDonateAmountOption;
@property (nonatomic, assign) double donateAmount;

- (IBAction)onDonateButton:(id)sender;
- (void)initDonateAmountArray;

@end

@implementation DonateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        [self initDonateAmountArray];
        self.selectedDonateAmountOption = DonateAmountOption1;
        self.donateAmount = [self.donateAmounts[DonateAmountOption1][@"value"] doubleValue];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStylePlain target: self action: @selector(onCancelTapped)];
    
    self.bannerView.doctor = self.doctor;

    [self.tableView registerNib:[UINib nibWithNibName:@"DonateCell" bundle:nil] forCellReuseIdentifier:@"DonateCell"];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
}

- (void)onCancelTapped {
    NSLog(@"DonateViewController: on Navigation bar Cancel tapped");
    [self dismissViewControllerAnimated: YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.donateAmounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DonateCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DonateCell"];
    cell.delegate = self;
    [cell setDonateAmountText:self.donateAmounts[indexPath.row][@"name"]];
    if (indexPath.row == self.selectedDonateAmountOption) {
        [cell setChecked:YES];
    } else {
        [cell setChecked:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectedDonateAmountOption = indexPath.row;
    self.donateAmount = [self.donateAmounts[indexPath.row][@"value"] doubleValue];
    [tableView reloadData];
    DonateCell *cell = (DonateCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == DonateAmountOptionCustom) {
        [cell setDonateAmountText:@"$50.00"];
        [cell enableEdit];
    }
}

#pragma mark - private methods

- (IBAction)onDonateButton:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"Donated %f", self.donateAmount);
    NSDictionary *paymentInfo = [User paymentInfo];
    if (paymentInfo == nil) {
        PaymentFormViewController *pvc = [[PaymentFormViewController alloc] init];
        pvc.doctor = self.doctor;
        [self.navigationController pushViewController:pvc animated:YES];
    } else {
        [[SamahopeClient sharedInstance] makeDonation:paymentInfo completion:^(bool success, NSError *error) {
            if (success) {
                // Go to Thanks View Controller
                ThanksViewController *tvc = [[ThanksViewController alloc] init];
                tvc.doctor = self.doctor;
                [self.navigationController pushViewController:tvc animated:YES];
            }
        }];
        NSLog(@"Pay with params: %@", paymentInfo);
    }
}

- (void)initDonateAmountArray {
    self.donateAmounts = @[
                           @{@"name" : @"$10.00", @"value" : @(10.00)},
                           @{@"name" : @"$25.00", @"value" : @(25.00)},
                           @{@"name" : @"Custom", @"value" : @(50.00)}
                           ];
}

#pragma mark - Donate cell methods

- (void)donateCell:(DonateCell *)cell didUpdateValue:(double)value {
    NSLog(@"Received donate value: %f", value);
    self.donateAmount = value;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
