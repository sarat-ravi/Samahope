//
//  User.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.id = dictionary[@"id"];
    }

    return self;
}

static NSDictionary *_paymentInfo = nil;

NSString * const kPaymentInfoKey = @"kPaymentInfoKey";

+ (NSDictionary *)paymentInfo {
    if (_paymentInfo == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kPaymentInfoKey];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _paymentInfo = dictionary;
        }
    }

    return _paymentInfo;
}

+ (void)setPaymentInfo:(NSDictionary *)paymentInfo {
    _paymentInfo = paymentInfo;

    if (_paymentInfo != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:paymentInfo options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kPaymentInfoKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kPaymentInfoKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
