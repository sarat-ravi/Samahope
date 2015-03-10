//
//  Fund.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "Fund.h"
#import "Doctor.h"

@interface Fund()

@property (strong, nonatomic) NSDictionary *dictionary;

@end

@implementation Fund

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.amountNeededForCurrentTreatment = [dictionary[@"amountNeededForCurrentTreatment"] integerValue];
        self.amountNeededPerTreatment = [dictionary[@"amountNeededPerTreatment"] integerValue];
        self.numberOfTreatmentsFunded = [dictionary[@"numberOfTreatmentsFunded"] integerValue];
        self.numberOfTreatmentsNeeded = [dictionary[@"numberOfTreatmentsNeeded"] integerValue];
        self.numberOfPeopleDonated = [dictionary[@"numberOfPeopleDonated"] integerValue];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Fund: %@", self.dictionary];
}

@end
