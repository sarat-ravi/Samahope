//
//  FormSwitchCell.m
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "FormSwitchCell.h"

@interface FormSwitchCell()
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

- (IBAction)onToggleSwitch:(id)sender;

@end

@implementation FormSwitchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onToggleSwitch:(id)sender {
    [self.delegate formSwitchCell:self shouldRememberUserInfo:self.toggleSwitch.on];
}
@end
