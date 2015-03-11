//
//  FormDateCell.h
//  Samahope
//
//  Created by Charlie Hu on 3/10/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FormDateCell;

@protocol FormDateCellDelegate <NSObject>

- (void)formDateCell:(FormDateCell *)cell didUpdateMonth:(NSString *)month year:(NSString *)year;

@end

@interface FormDateCell : UITableViewCell

@property (nonatomic, weak) id<FormDateCellDelegate> delegate;

@end
