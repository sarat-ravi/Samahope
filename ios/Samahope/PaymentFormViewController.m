//
//  PaymentFormViewController.m
//  Samahope
//
//  Created by Charlie Hu on 3/17/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "PaymentFormViewController.h"
#import "FXForms/FXForms.h"
#import "PaymentForm.h"
#import "BannerView.h"
#import "SamahopeClient.h"
#import "User.h"
#import "ThanksViewController.h"

@interface PaymentFormViewController () <FXFormControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FXFormController *formController;
@property (weak, nonatomic) IBOutlet BannerView *bannerView;
@property (nonatomic, strong) PaymentForm *paymentForm;

- (IBAction)onDonateButton:(id)sender;

- (NSMutableDictionary *)paymentParams;
@end

@implementation PaymentFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.formController = [[FXFormController alloc] init];
    self.formController.tableView = self.tableView;
    self.formController.delegate = self;
    self.paymentForm = [[PaymentForm alloc] init];
    self.formController.form = self.paymentForm;

    self.bannerView.doctor = self.doctor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //reload the table
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateFields
{
    //refresh the form
    self.formController.form = self.formController.form;
    [self.tableView reloadData];
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
    NSMutableDictionary *params = [self paymentParams];
    NSLog(@"Donate with params: %@", params);

    [[SamahopeClient sharedInstance] makeDonation:params completion:^(bool success, NSError *error) {
        if (success) {
            if (self.paymentForm.rememberCard) {
                // Persist user info.
                NSLog(@"Persist user info");
                [User setPaymentInfo:params];
            }

            // Go to Thanks View Controller
            ThanksViewController *tvc = [[ThanksViewController alloc] init];
            tvc.doctor = self.doctor;
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }];
}

- (NSMutableDictionary *)paymentParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.paymentForm.nameOnCard forKey:@"name"];
    [params setObject:self.paymentForm.cardNumber forKey:@"cardNumber"];
    [params setObject:self.paymentForm.address forKey:@"address"];
    [params setObject:self.paymentForm.city forKey:@"city"];
    [params setObject:self.paymentForm.state forKey:@"state"];
    [params setObject:self.paymentForm.zipCode forKey:@"zipCode"];
    [params setObject:[NSNumber numberWithInteger:self.paymentForm.expirationYear] forKey:@"expirationYear"];
    [params setObject:[NSNumber numberWithInteger:self.paymentForm.expirationMonth] forKey:@"expirationMonth"];
    [params setObject:self.paymentForm.CVN forKey:@"CVN"];

    return params;
}

@end
