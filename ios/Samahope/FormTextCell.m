//
//  FormTextCell.m
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "FormTextCell.h"

@interface FormTextCell()
@property (weak, nonatomic) IBOutlet UILabel *fieldNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *fieldTextField;

@end

@implementation FormTextCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFieldName:(NSString *)fieldName {
    self.fieldNameLabel.text = fieldName;
}

@end
