//
//  DoctorDetailView.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DoctorDetailView.h"

@interface DoctorDetailView()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation DoctorDetailView

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
    UINib *nib = [UINib nibWithNibName: @"DoctorDetailView" bundle:nil];
    [nib instantiateWithOwner: self options:nil];
    // Content view is the top level view.
    self.contentView.frame = self.bounds;
    [self addSubview: self.contentView];
}

#pragma mark Core

-(void) setDoctor:(Doctor *)doctor {
    _doctor = doctor;
}

@end
