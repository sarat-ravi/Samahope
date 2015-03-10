//
//  DonateViewController.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DonateViewController.h"
#import "DonateCell.h"
#import "PaymentViewController.h"

typedef NS_ENUM(NSInteger, DonateAmountOption) {
    DonateAmountOption1 = 0,
    DonateAmountOption2,
    DonateAmountOptionCustom
};

@interface DonateViewController () <UITableViewDataSource, UITableViewDelegate, DonateCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

    [self.tableView registerNib:[UINib nibWithNibName:@"DonateCell" bundle:nil] forCellReuseIdentifier:@"DonateCell"];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    [cell setDonateAmountText:self.donateAmounts[indexPath.row][@"name"]];
    if (indexPath.row == self.selectedDonateAmountOption) {
        [cell setChecked:YES];
    } else {
        [cell setChecked:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedDonateAmountOption = indexPath.row;
    self.donateAmount = [self.donateAmounts[indexPath.row][@"value"] doubleValue];
    [tableView reloadData];
    DonateCell *cell = (DonateCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == DonateAmountOptionCustom) {
        [cell setDonateAmountText:@"$1.00"];
        [cell enableEdit];
    }
}

#pragma mark - private methods

- (IBAction)onDonateButton:(id)sender {
    NSLog(@"Donated %f", self.donateAmount);
    [self.navigationController pushViewController:[[PaymentViewController alloc] init] animated:YES];
}

- (void)initDonateAmountArray {
    self.donateAmounts = @[
                           @{@"name" : @"$10.00", @"value" : @(10.00)},
                           @{@"name" : @"$25.00", @"value" : @(25.00)},
                           @{@"name" : @"Custom", @"value" : @(1.00)}
                           ];
}

#pragma mark - Donate cell methods

- (void)donateCell:(DonateCell *)cell didUpdateValue:(NSString *)value {
    self.donateAmount = [value doubleValue];
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
