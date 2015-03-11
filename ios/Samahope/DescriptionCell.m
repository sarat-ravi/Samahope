//
//  DescriptionCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/11/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DescriptionCell.h"

@interface DescriptionCell()

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *quoteLabel;
@property (strong, nonatomic) IBOutlet UILabel *livesChangedLabel;

@end

@implementation DescriptionCell

#pragma mark Constructors

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Core

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    self.quoteLabel.text = [NSString stringWithFormat: @"\"%@\"", doctor.quote];
    self.descriptionLabel.text = [self formatDescription: doctor.personalDescription];
    self.livesChangedLabel.text = [NSString stringWithFormat: @"Some lives changed by %@", doctor.name];
}

- (NSString*)formatDescription: (NSString *)description {
    return [NSString stringWithFormat: @"%@ ... Read More", [description substringToIndex: 200]];
}

@end
