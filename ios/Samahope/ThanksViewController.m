//
//  ThanksViewController.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "ThanksViewController.h"
#import "BannerView.h"
#import "DoctorsViewController.h"

@interface ThanksViewController ()
@property (weak, nonatomic) IBOutlet BannerView *bannerView;

- (IBAction)onLogoButton:(id)sender;
@end

@implementation ThanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.bannerView.doctor = self.doctor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLogoButton:(id)sender {
    DoctorsViewController *dvc = [[DoctorsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController: dvc];

    UIColor *globalTint = [[[UIApplication sharedApplication] delegate] window].tintColor;

    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : globalTint}];

    [self presentViewController:nvc animated:YES completion:nil];
}
@end
