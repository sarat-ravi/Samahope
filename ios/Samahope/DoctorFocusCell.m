//
//  DoctorFocusCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorFocusCell.h"
#import "DoctorFocusView.h"

@interface DoctorFocusCell()

@property (strong, nonatomic) IBOutlet DoctorFocusView *doctorFocusView;

@end

@implementation DoctorFocusCell

#pragma mark Constructors

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Core

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    self.doctorFocusView.doctor = doctor;
}

@end
