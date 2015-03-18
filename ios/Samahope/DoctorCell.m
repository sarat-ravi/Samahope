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

@property (strong, nonatomic) IBOutlet BannerView *bannerView;
@property (strong, nonatomic) IBOutlet FundView *fundView;
@property (strong, nonatomic) IBOutlet DoctorFocusView *doctorFocusView;

@end

@implementation DoctorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    // [self.profileImageView setImageWithURL: [NSURL URLWithString: doctor.profileImageUrlString]];
    self.bannerView.doctor = doctor;
    self.bannerView.maskAlpha = 0.0;
    self.fundView.fund = doctor.fund;
    self.doctorFocusView.doctor = doctor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
