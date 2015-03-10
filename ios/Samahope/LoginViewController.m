//
//  LoginViewController.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "DoctorsViewController.h"
#import "DonateViewController.h"
#import "SamahopeClient.h"

@interface LoginViewController () <FBLoginViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    
    [[SamahopeClient sharedInstance] fetchDataWithCompletion:^(NSArray *doctors, NSError *error) {
        NSLog(@"completion");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FB Login delegate methods

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    NSLog(@"%@", user);
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    //[self presentViewController:[[DonateViewController alloc] init] animated:YES completion:nil];
    // loginView.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    // [self.view addSubview:loginView];
    //DoctorsViewController *dvc = [[DoctorsViewController alloc] init];
    DonateViewController *dvc = [[DonateViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController: dvc];
    [self presentViewController:nvc animated:YES completion:^{
        // Completion
    }];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    loginView.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view addSubview:loginView];
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
