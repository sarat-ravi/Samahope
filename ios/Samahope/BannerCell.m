//
//  BannerCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/17/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "BannerCell.h"
#import "BannerView.h"

@interface BannerCell()

@property (strong, nonatomic) IBOutlet BannerView *bannerView;

@end

@implementation BannerCell

#pragma mark Constructors

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Core

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    self.bannerView.doctor = doctor;
}

- (void)setMaskAlpha:(CGFloat)maskAlpha {
    _maskAlpha = maskAlpha;
    self.bannerView.maskAlpha = maskAlpha;
}

@end
