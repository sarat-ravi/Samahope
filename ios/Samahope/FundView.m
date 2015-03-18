//
//  FundView.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "FundView.h"

@interface FundView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *moreNeededLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfTreatmentsFundedLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPeopleDonatedLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *treatmentProgressBar;

@end

@implementation FundView

#pragma mark Constructors

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    UINib *nib = [UINib nibWithNibName: @"FundView" bundle:nil];
    [nib instantiateWithOwner: self options:nil];
    self.contentView.frame = self.bounds;
    [self addSubview: self.contentView];
}

#pragma mark Core

- (void)setFund:(Fund *)fund {
    _fund = fund;
    
    self.moreNeededLabel.text = [NSString stringWithFormat: @"$%ld", (long)[self.fund amountNeededForCurrentTreatment]];
    self.numberOfTreatmentsFundedLabel.text = [NSString stringWithFormat: @"%ld", (long)[self.fund numberOfTreatmentsFunded]];
    self.numberOfPeopleDonatedLabel.text = [NSString stringWithFormat: @"%ld", (long)[self.fund numberOfPeopleDonated]];
    
    // Calculate percentage progress for the fund.
//    NSInteger totalCost = (self.fund.numberOfTreatmentsNeeded + self.fund.numberOfTreatmentsFunded) * self.fund.amountNeededPerTreatment;
//    NSInteger raised = (self.fund.numberOfTreatmentsFunded * self.fund.amountNeededPerTreatment)
//                        + (self.fund.amountNeededPerTreatment - self.fund.amountNeededForCurrentTreatment);
    
    NSInteger totalCost = self.fund.amountNeededPerTreatment;
    NSInteger raised = self.fund.amountNeededPerTreatment - self.fund.amountNeededForCurrentTreatment;
    
    CGFloat progress = (float) raised / totalCost;
    [self.treatmentProgressBar setProgress:progress animated:YES];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    self.treatmentProgressBar.transform = transform;

}

@end
