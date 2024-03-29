//
//  SamahopeClient.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SamahopeClient : NSObject

+ (SamahopeClient *)sharedInstance;

- (void)makeDonation:(NSDictionary *)information completion:(void(^)(bool success, NSError *error))completion;

- (void)fetchDataWithCompletion:(void (^)(NSArray *doctors, NSError *error))completion;

@end
