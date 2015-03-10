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

@interface PaymentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *formFields;

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"FormDateCell" bundle:nil] forCellReuseIdentifier:@"FormDateCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FormTextCell" bundle:nil] forCellReuseIdentifier:@"FormTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FormSwitchCell" bundle:nil] forCellReuseIdentifier:@"FormSwitchCell"];

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

    if (indexPath.row == PaymentFormTypeExpiration) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FormDateCell"];
    } else if (indexPath.row == PaymentFormTypeRememberCard) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FormSwitchCell"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FormTextCell"];
        [(FormTextCell *)cell setFieldName:self.formFields[indexPath.row][@"name"]];
    }

    return cell;
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

@end
