//
//  FormTextCell.h
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FormTextCell;

@protocol FormTextCellDelegate <NSObject>

- (void)formTextCell:(FormTextCell *)cell didUpdateValue:(NSString *)value;

@end

@interface FormTextCell : UITableViewCell

@property (nonatomic, weak) id<FormTextCellDelegate> delegate;

- (void)setFieldName:(NSString *)fieldName;

@end
