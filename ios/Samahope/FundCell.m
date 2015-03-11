//
//  FundCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "FundCell.h"
#import "FundView.h"

@interface FundCell()

@property (strong, nonatomic) IBOutlet FundView *fundView;

@end

@implementation FundCell

#pragma mark Constructors

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Core

- (void)setFund:(Fund *)fund {
    _fund = fund;
    self.fundView.fund = fund;
}

@end
