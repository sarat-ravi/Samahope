//
//  SimpleDonateCell.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/24/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "SimpleDonateCell.h"

@interface SimpleDonateCell()

@property (strong, nonatomic) IBOutlet UIImageView *checkImageView;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation SimpleDonateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    if (checked) {
        self.checkImageView.image = [UIImage imageNamed: @"checked"];
    } else {
        self.checkImageView.image = [UIImage imageNamed: @"unchecked"];
    }
    
    self.checkImageView.image = [self.checkImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setAmount:(double)amount {
    _amount = amount;
    NSString *amountString = [NSString stringWithFormat: @"$%0.2f", amount];
    self.amountLabel.text = amountString;
}

@end
