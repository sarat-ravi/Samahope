//
//  FormSwitchCell.h
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FormSwitchCell;

@protocol FormSwitchCellDelegate <NSObject>

- (void)formSwitchCell:(FormSwitchCell *)cell shouldRememberUserInfo:(BOOL)shouldRememberUserInfo;

@end

@interface FormSwitchCell : UITableViewCell

@property (nonatomic, weak) id<FormSwitchCellDelegate> delegate;

@end
