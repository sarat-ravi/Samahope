//
//  DoctorCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorCell.h"
#import "UIImageView+AFNetworking.h"
#import "FundView.h"
#import "DoctorFocusView.h"
#import "BannerView.h"

@interface DoctorCell()

@property (strong, nonatomic) IBOutlet FundView *fundView;
@property (strong, nonatomic) IBOutlet DoctorFocusView *doctorFocusView;

@end

@implementation DoctorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    NSLog(@"DoctorCell: setHighlighted: %d animated: %d", highlighted, animated);
    if (highlighted) {
        self.bannerView.maskAlpha = 0.5;
        self.fundView.alpha = 0.5;
        self.doctorFocusView.alpha = 0.5;
    } else {
        self.bannerView.maskAlpha = 0.0;
        self.fundView.alpha = 1.0;
        self.doctorFocusView.alpha = 1.0;
    }
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    // [self.profileImageView setImageWithURL: [NSURL URLWithString: doctor.profileImageUrlString]];
    self.bannerView.doctor = doctor;
    self.bannerView.maskAlpha = 0.0;
    self.fundView.fund = doctor.fund;
    self.doctorFocusView.doctor = doctor;
}

@end
