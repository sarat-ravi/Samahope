//
//  DoctorCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorCell.h"
#import "UIImageView+AFNetworking.h"

@interface DoctorCell()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *fundContentView;
@property (strong, nonatomic) IBOutlet UIView *focusContentView;
@property (strong, nonatomic) IBOutlet UIView *nameLabelBackgroundView;

@end

@implementation DoctorCell

- (void)awakeFromNib {
    // Initialization code
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.nameLabelBackgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite: 1.0 alpha:0.0] CGColor],
                       (id)[[UIColor colorWithWhite: 1.0 alpha:1.0] CGColor], nil];
    gradient.startPoint = CGPointMake(0.5, 0.0); // default; bottom of the view
    gradient.endPoint = CGPointMake(0.5, 0.5);   // default; top of the view
    [self.nameLabelBackgroundView.layer insertSublayer:gradient atIndex:0];
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    // [self.profileImageView setImageWithURL: [NSURL URLWithString: doctor.profileImageUrlString]];
    [self.profileImageView setImageWithURL: [NSURL URLWithString: doctor.fullScreenImageUrlString]];
    self.nameLabel.text = doctor.name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
