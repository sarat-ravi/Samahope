//
//  PaymentViewController.m
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "PaymentViewController.h"
#import "FormTextCell.h"
#import "FormDateCell.h"
#import "FormSwitchCell.h"
#import "User.h"
#import "BannerView.h"
#import "SamahopeClient.h"
#import "ThanksViewController.h"

typedef NS_ENUM(NSInteger, PaymentFormType) {
    PaymentFormTypeName = 0,
    PaymentFormTypeAddress,
    PaymentFormTypeCity,
    PaymentFormTypeState,
    PaymentFormTypeZip,
    PaymentFormTypeCardNumber,
    PaymentFormTypeExpiration,
    PaymentFormTypeCVN,
    PaymentFormTypeRememberCard
};

@interface PaymentViewController () <UITableViewDelegate, UITableViewDataSource, FormTextCellDelegate, FormDateCellDelegate, FormSwitchCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *formFields;
@property (nonatomic, strong) NSMutableDictionary *formValues;
@property (nonatomic, assign) BOOL shouldRememberUserInfo;
@property (strong, nonatomic) IBOutlet BannerView *bannerView;

- (IBAction)onDonateButton:(id)sender;
@end

@implementation PaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        [self initFormFields];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.formValues = [NSMutableDictionary dictionary];
    self.shouldRememberUserInfo = YES;

    self.bannerView.doctor = self.doctor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"FormDateCell" bundle:nil] forCellReuseIdentifier:@"FormDateCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FormTextCell" bundle:nil] forCellReuseIdentifier:@"FormTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FormSwitchCell" bundle:nil] forCellReuseIdentifier:@"FormSwitchCell"];

    self.tableView.rowHeight = UITableViewAutomaticDimension;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.formFields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;

    FormTextCell *tcell;
    FormDateCell *dcell;
    FormSwitchCell *scell;

    if (indexPath.row == PaymentFormTypeExpiration) {
        dcell = [tableView dequeueReusableCellWithIdentifier:@"FormDateCell"];
        dcell.delegate = self;
        cell = dcell;
    } else if (indexPath.row == PaymentFormTypeRememberCard) {
        scell = [tableView dequeueReusableCellWithIdentifier:@"FormSwitchCell"];
        scell.delegate = self;
        cell = scell;
    } else {
        tcell = [tableView dequeueReusableCellWithIdentifier:@"FormTextCell"];
        [tcell setFieldName:self.formFields[indexPath.row][@"name"]];
        tcell.delegate = self;
        cell = tcell;
    }
    return cell;
}

#pragma mark - form text cell methods

- (void)formTextCell:(FormTextCell *)cell didUpdateValue:(NSString *)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.formValues setObject:value forKey:self.formFields[indexPath.row][@"name"]];
}

#pragma mark - form date cell methods

- (void)formDateCell:(FormDateCell *)cell didUpdateMonth:(NSString *)month year:(NSString *)year {
    [self.formValues setObject:month forKey:@"Expiration_Month"];
    [self.formValues setObject:year forKey:@"Expiration_Year"];
}

#pragma mark - form switch cell methods

- (void)formSwitchCell:(FormSwitchCell *)cell shouldRememberUserInfo:(BOOL)shouldRememberUserInfo {
    self.shouldRememberUserInfo = shouldRememberUserInfo;
}

#pragma mark - private methods

- (void)initFormFields {
    self.formFields = @[
                        @{@"name" : @"Name"},
                        @{@"name" : @"Address"},
                        @{@"name" : @"City"},
                        @{@"name" : @"State"},
                        @{@"name" : @"Zip"},
                        @{@"name" : @"Card Number"},
                        @{@"name" : @"Expiration"},
                        @{@"name" : @"CVN"},
                        @{@"name" : @"Remember Cards"}
                        ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onDonateButton:(id)sender {
    NSLog(@"Donate with params: %@", self.formValues);

    [[SamahopeClient sharedInstance] makeDonation:self.formValues completion:^(bool success, NSError *error) {
        if (success) {
            if (self.shouldRememberUserInfo) {
                // Persist user info.
                NSLog(@"Persist user info");
                [User setPaymentInfo:self.formValues];
            }

            // Go to Thanks View Controller
            ThanksViewController *tvc = [[ThanksViewController alloc] init];
            tvc.doctor = self.doctor;
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }];
}
@end
