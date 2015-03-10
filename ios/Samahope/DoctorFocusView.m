//
//  DoctorFocusView.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/9/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorFocusView.h"
#import "UIImageView+AFNetworking.h"
#import "Focus.h"

@interface DoctorFocusView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *focusThumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *focusNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *humanReadableLocationLabel;

@end

@implementation DoctorFocusView

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
    UINib *nib = [UINib nibWithNibName: @"DoctorFocusView" bundle:nil];
    [nib instantiateWithOwner: self options:nil];
    // Content view is the top level view.
    self.contentView.frame = self.bounds;
    [self addSubview: self.contentView];
}

#pragma mark Core

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    Focus *primaryFocus = doctor.focuses[0];
    [self.focusThumbnailImageView setImageWithURL: [NSURL URLWithString: primaryFocus.thumbnailImageUrlString]];
    self.focusNameLabel.text = primaryFocus.name;
    self.humanReadableLocationLabel.text = doctor.humanReadableLocation;
    NSLog(@"DoctorFocusView: primaryFocus=%@, location=%@, url=%@", primaryFocus.name, doctor.humanReadableLocation, primaryFocus.thumbnailImageUrlString);
}

@end
