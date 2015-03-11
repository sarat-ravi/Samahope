//
//  ParseClient.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "ParseClient.h"
#import <Parse/Parse.h>
#import "User.h"

@implementation ParseClient

+ (ParseClient *)sharedInstance {
    static ParseClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[ParseClient alloc] init];
        }
    });
    
    return instance;
}


- (void)saveUser:(NSDictionary *)fbUser completion:(void (^)(BOOL succeeded, NSError *error))completion {
    
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"fbId"] = fbUser[@"id"];
    user[@"name"] = fbUser[@"id"];
    user[@"firstName"] = fbUser[@"first_name"];
    user[@"lastName"] = fbUser[@"last_name"];
    user[@"fbLink"] = fbUser[@"link"];
    user[@"gender"] = fbUser[@"gender"];
    
    [user saveInBackgroundWithBlock:completion];
}

- (void)getUserById:(NSString *)fbUserId completion:(void (^)(BOOL succeeded, NSError *error))completion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"User" predicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"fbId = '%@'", fbUserId]]];

    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            User *user = [[User alloc] init];
            completion(user, nil);
        } else {
            completion(nil, error);
        }
    }];
}

- (void)saveFund:(NSDictionary *)fund completion:(void (^)(BOOL succeeded, NSError *error))completion {
    
//    PFObject *user = [PFObject objectWithClassName:@"Fund"];
//    user[@"fbId"] = fbUser[@"id"];
//    user[@"name"] = fbUser[@"id"];
//    user[@"firstName"] = fbUser[@"first_name"];
//    user[@"lastName"] = fbUser[@"last_name"];
//    user[@"fbLink"] = fbUser[@"link"];
//    user[@"gender"] = fbUser[@"gender"];
//    
//    [user saveInBackgroundWithBlock:completion];

}

@end
