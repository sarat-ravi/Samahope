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

@interface DoctorCell()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *focusContentView;
@property (strong, nonatomic) IBOutlet UIView *nameLabelBackgroundView;
@property (strong, nonatomic) IBOutlet FundView *fundView;

@end

@implementation DoctorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    // [self.profileImageView setImageWithURL: [NSURL URLWithString: doctor.profileImageUrlString]];
    [self.profileImageView setImageWithURL: [NSURL URLWithString: doctor.fullScreenImageUrlString]];
    self.nameLabel.text = doctor.name;
    self.fundView.fund = doctor.fund;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
