//
//  Focus.h
//  Samahope
//
//  Created by Sarat Tallamraju on 3/8/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Focus : NSObject

#pragma mark Constructors
- (id)initWithDictionary: (NSDictionary *)dictionary;

#pragma mark Core Properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *thumbnailImageUrlString;
@property (nonatomic, strong) NSString *focusDescription;

@end
