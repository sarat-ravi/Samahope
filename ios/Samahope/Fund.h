//
//  Fund.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Fund : NSObject

#pragma mark Constructors
- (id)initWithDictionary: (NSDictionary *)dictionary;

#pragma mark Core Properties
@property (nonatomic, assign) NSInteger amountNeededForCurrentTreatment;
@property (nonatomic, assign) NSInteger amountNeededPerTreatment;
@property (nonatomic, assign) NSInteger numberOfTreatmentsFunded;
@property (nonatomic, assign) NSInteger numberOfTreatmentsNeeded;

#pragma mark Misc Properties
@property (nonatomic, assign) NSInteger numberOfPeopleDonated;
@property (nonatomic, strong) NSDictionary *costBreakdown;

@end
