//
//  DonateCell.m
//  Samahope
//
//  Created by Charlie Hu on 3/6/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DonateCell.h"

@interface DonateCell ()
@property (weak, nonatomic) IBOutlet UITextField *donateAmountTextField;
@property (weak, nonatomic) IBOutlet UIImageView *checkButtonImageView;


@end

@implementation DonateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDonateAmountText:(NSString *)donateAmountText {
    self.donateAmountTextField.text = donateAmountText;
}

- (void)enableEdit {
    [self.donateAmountTextField becomeFirstResponder];
    self.donateAmountTextField.borderStyle = UITextBorderStyleRoundedRect;

}

- (void)setChecked:(BOOL)checked {
    if (checked) {
        [self.checkButtonImageView setImage:[UIImage imageNamed:@"checked"]];
    } else {
        [self.checkButtonImageView setImage:[UIImage imageNamed:@"unchecked"]];
    }
}

@end
