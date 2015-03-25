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
#import "BannerView.h"

NSString *const kDoctorCellName = @"DoctorCell";

@interface DoctorsViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic) IBOutlet UITableView *doctorsTableView;
@property (strong, nonatomic) NSArray *doctors;
@property (nonatomic, assign) CGFloat transitionDuration;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, strong) Doctor *selectedDoctor;
@property (nonatomic, assign) CGRect selectedDoctorCellRect;

@end

@implementation DoctorsViewController

#pragma mark View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Doctors";
    
    self.transitionDuration = 0.5;
    
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation: UIStatusBarAnimationFade];
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

#pragma mark UI Animated Transitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    if (self.isPresenting) {
        [containerView addSubview: toViewController.view];
        toViewController.view.bounds = containerView.bounds;
        toViewController.view.center = CGPointMake(containerView.center.x + screenWidth, containerView.center.y);
        
        BannerView *bannerView = [[BannerView alloc] initWithFrame: CGRectMake(0, self.selectedDoctorCellRect.origin.y, screenWidth, 170)];
        [containerView addSubview: bannerView];
        bannerView.maskAlpha = 0.0;
        bannerView.doctor = self.selectedDoctor;
        // bannerView.alpha = 0.0;
        
        [UIView animateWithDuration: self.transitionDuration animations:^{
            toViewController.view.center = CGPointMake(containerView.center.x, containerView.center.y);
            bannerView.frame = CGRectMake(0, 0, screenWidth, 170);
            // bannerView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition: YES];
            [bannerView removeFromSuperview];
        }];
    } else {
        BannerView *bannerView = [[BannerView alloc] initWithFrame: CGRectMake(0, 0, screenWidth, 170)];
        [containerView addSubview: bannerView];
        bannerView.maskAlpha = 0.0;
        bannerView.doctor = self.selectedDoctor;
        
        [UIView animateWithDuration: self.transitionDuration animations:^{
            fromViewController.view.center = CGPointMake(containerView.center.x + screenWidth, containerView.center.y);
            bannerView.frame = CGRectMake(0, self.selectedDoctorCellRect.origin.y, screenWidth, 170);
            // bannerView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition: YES];
            [fromViewController.view removeFromSuperview];
        }];
    }
}

#pragma mark UI Transition Delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

#pragma mark Table View Listeners

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCell *cell = [self.doctorsTableView dequeueReusableCellWithIdentifier: kDoctorCellName forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    CGRect rectOfCellInTableView = [tableView rectForRowAtIndexPath:indexPath];
    self.selectedDoctorCellRect = [tableView convertRect:rectOfCellInTableView toView:[tableView superview]];
    self.selectedDoctor = self.doctors[indexPath.row];
    
    DoctorDetailViewController *vc = [[DoctorDetailViewController alloc] init];
    vc.doctor = self.selectedDoctor;
    // vc.modalPresentationStyle = UIModalPresentationPopover;
    // vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController: vc animated:YES completion:nil];
    // [self.navigationController pushViewController: vc animated:YES];
}

@end
