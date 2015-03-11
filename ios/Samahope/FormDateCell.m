//
//  FormDateCell.m
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "FormDateCell.h"

@interface FormDateCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *monthField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;

- (IBAction)monthDidEndEditing:(id)sender;

- (IBAction)yearDidEndEditing:(id)sender;
@end

@implementation FormDateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)monthDidEndEditing:(id)sender {
    NSLog(@"Month: %@", self.monthField.text);
    [self.delegate formDateCell:self didUpdateMonth:self.monthField.text year:self.yearField.text];
}

- (IBAction)yearDidEndEditing:(id)sender {
    NSLog(@"Year: %@", self.yearField.text);
    [self.delegate formDateCell:self didUpdateMonth:self.monthField.text year:self.yearField.text];
}
@end
