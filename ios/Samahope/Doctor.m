//
//  Doctor.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // Code to init from dictionary here.
        self.name = dictionary[@"name"];
        self.profileImageUrlString = dictionary[@"profileImageUrlString"];
        self.tagLine = dictionary[@"tagLine"];
        self.personalDescription = dictionary[@"personalDescription"];
        self.parentOrganization = dictionary[@"parentOrganization"];
        
        self.fund = [[Fund alloc] initWithDictionary: dictionary[@"fund"]];
        
        NSMutableArray *focuses = [NSMutableArray array];
        for (NSDictionary *focusDictionary in dictionary[@"focuses"]) {
            Focus *focus = [[Focus alloc] initWithDictionary: focusDictionary];
            [focuses addObject: focus];
        }
        
        self.fullScreenImageUrlString = dictionary[@"fullScreenImageUrlString"];
        self.videoUrlString = dictionary[@"videoUrlString"];
        self.quote = dictionary[@"quote"];
        self.humanReadableLocation = dictionary[@"humanReadableLocation"];
    }
    return self;
}

@end
