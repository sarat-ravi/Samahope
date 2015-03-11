//
//  PatientCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "PatientCell.h"
#import "UIImageView+AFNetworking.h"
// #import "Patient.h"

@interface PatientCell()
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation PatientCell

#pragma mark Constructors

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Core

- (void)setPatient:(Patient *)patient {
    _patient = patient;
    
    [self.thumbnailImageView setImageWithURL: [NSURL URLWithString: patient.profileImageUrlString]];
    self.nameLabel.text = patient.name;
    self.descriptionLabel.text = [self formatDescription: patient.personalDescription];
}

- (NSString *)formatDescription: (NSString *)description {
    return [NSString stringWithFormat: @"%@ ... Read More",[description substringToIndex: 120]];
}

@end
