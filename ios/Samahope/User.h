//
//  User.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;

+ (NSDictionary *)paymentInfo;
+ (void)setPaymentInfo:(NSDictionary *)paymentInfo;

@end
