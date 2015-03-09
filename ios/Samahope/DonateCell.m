//
//  DonateCell.m
//  Samahope
//
//  Created by Charlie Hu on 3/6/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "DonateCell.h"

@interface DonateCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *donateAmountTextField;
@property (weak, nonatomic) IBOutlet UIImageView *checkButtonImageView;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end

@implementation DonateCell

- (void)awakeFromNib {
    // Initialization code
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCell:)];
//    tapGesture.numberOfTapsRequired = 1;
//    [self.cellView addGestureRecognizer:tapGesture];
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

#pragma mark - text field delegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate donateCell:self didUpdateValue:textField.text];
}

- (IBAction)onTapCell:(UITapGestureRecognizer *)sender {
    if (self.donateAmountTextField.isFirstResponder) {
        [self.donateAmountTextField resignFirstResponder];
    }
}
@end
