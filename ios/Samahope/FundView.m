//
//  FundView.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "FundView.h"

@interface FundView()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation FundView

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
    UINib *nib = [UINib nibWithNibName: @"FundView" bundle:nil];
    [nib instantiateWithOwner: self options:nil];
    self.contentView.frame = self.bounds;
    [self addSubview: self.contentView];
}

@end
