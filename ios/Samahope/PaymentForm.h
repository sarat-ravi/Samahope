//
//  Payment.h
//  Samahope
//
//  Created by Charlie Hu on 3/17/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXForms/FXForms.h>

@interface PaymentForm : NSObject <FXForm>

@property (nonatomic, copy) NSString *nameOnCard;
@property (nonatomic, copy) NSNumber *cardNumber;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSNumber *zipCode;
@property (nonatomic, assign) NSUInteger expirationMonth;
@property (nonatomic, assign) NSUInteger expirationYear;
@property (nonatomic, copy) NSNumber *CVN;
@property (nonatomic, assign) BOOL rememberCard;

@end
