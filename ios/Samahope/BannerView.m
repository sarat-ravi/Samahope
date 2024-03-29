//
//  BannerView.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "BannerView.h"
#import "UIImageView+AFNetworking.h"

@interface BannerView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *imageMaskView;
@property (strong, nonatomic) IBOutlet UIView *labelBackgroundView;

@end

@implementation BannerView

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
    UINib *nib = [UINib nibWithNibName: @"BannerView" bundle:nil];
    [nib instantiateWithOwner: self options:nil];
    // Content view is the top level view.
    self.contentView.frame = self.bounds;
    [self addSubview: self.contentView];
}

#pragma mark Core

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    [self.bannerImageView setImageWithURL: [NSURL URLWithString: doctor.fullScreenImageUrlString]];
    self.nameLabel.text = doctor.name;
}

- (void)setMaskAlpha:(CGFloat)maskAlpha {
    _maskAlpha = maskAlpha;
    self.imageMaskView.alpha = maskAlpha;
}

- (void)setLabelBackgroundAlpha:(CGFloat)labelBackgroundAlpha {
    NSLog(@"setLabelBackgroundAlpha called");
    _labelBackgroundAlpha= labelBackgroundAlpha;
    self.labelBackgroundView.alpha = labelBackgroundAlpha;
}

@end
