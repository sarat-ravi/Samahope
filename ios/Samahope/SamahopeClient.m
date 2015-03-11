//
//  SamahopeClient.m
//  Samahope
//
//  Created by Sarat Tallamraju on 3/4/15.
//  Copyright (c) 2015 Samahope Org. All rights reserved.
//

#import "SamahopeClient.h"
#import <AFNetworking.h>
#import "Doctor.h"

NSString *const kKimonoLabsKey = @"de529db82ec0c0037a7deedded30878a";

@implementation SamahopeClient

+ (SamahopeClient *)sharedInstance {
    static SamahopeClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[SamahopeClient alloc] init];
        }
    });
    
    return instance;
}

/*
 
    This is super important.  We don't have any error checking so we have to make sure that the following API is strictly enforced.  All of the request argument names must be case accurate to the keys that are in the information.
 
 
 doc = request.args.get("doctor")
 interval = request.args.get("interval") // MUST BE EITHER 'once' or 'monthly'
 amount = request.args.get("amount")
 first_name = request.args.get("firstName")
 last_name = request.args.get("lastName")
 email = request.args.get("email")
 card_number = request.args.get("cardNumber")
 security_code = request.args.get("securityCode")
 expiration_month = request.args.get("expirationMonth") // MUST BE TWO DIGITS
 expiration_year = request.args.get("expirationYear") // MUST BE FOUR DIGITS FROM 2015 to 2022
 address = request.args.get("address")
 city = request.args.get("city")
 state = request.args.get("state") // MUST BE Titlecase OF STATE NAME: 'California'
 zip_code = request.args.get("zip")

 
 */

- (void)makeDonation:(NSDictionary *)information completion:(void(^)(bool success, NSError *error))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = information;

    
    
    
    [manager GET:@"http://50.161.102.4:5000/donate" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response Object of donate: %@", responseObject);
        completion(true, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response Object of donate: %@", error);

        completion(false, error);
    }];
    
}

- (void)fetchDataWithCompletion:(void (^)(NSArray *doctors, NSError *error))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
    NSDictionary *parameters = @{@"apikey": kKimonoLabsKey};

    NSMutableArray *doctors = [[NSMutableArray alloc] init];
    
    [manager GET:@"https://www.kimonolabs.com/api/7fu7cppe" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);


        NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        NSDictionary *results = responseObject[@"results"];
        NSArray *categoryInfos = results[@"categoryInfo"];
        NSArray *doctorInfos = results[@"doctorInfo"];
        NSArray *patientInfos = results[@"patientInfo"];
        NSArray *fundInfos = results[@"fundInfo"];
        
//        NSLog(@"lenghts of apis: %ld %ld %ld %ld", [categoryInfos count], [doctorInfos count], [patientInfos count], [fundInfos count]);
        
        for (int i = 0; i < [doctorInfos count]; i++) {
            
            NSDictionary *doctorInfo = doctorInfos[i];
            NSDictionary *patientInfo = patientInfos[i];
            NSDictionary *categoryInfo = categoryInfos[i];
            NSDictionary *fundInfo = fundInfos[i];

            // NSLog(@"all info: %@ %@ %@ %@", doctorInfo, patientInfo, categoryInfo, fundInfo);
            
//            NSLog(@"fund numbers: %@ %@ %@", [fundInfo[@"amountNeeded"] stringByTrimmingCharactersInSet:nonDigits], [fundInfo[@"treatmentsFunded"] stringByTrimmingCharactersInSet:nonDigits], ([fundInfo[@"peopleDonated"] isKindOfClass:[NSNull class]] || fundInfo[@"peopleDonated"] == nil || fundInfo[@"peopleDonated"] == (id)[NSNull null]) ? 0 : [fundInfo[@"peopleDonated"] stringByTrimmingCharactersInSet:nonDigits]);

//            NSLog(@"doctorInfo: %@", fundInfo);

            NSDictionary *fund = @{
                                   @"amountNeededForCurrentTreatment": [fundInfo[@"amountNeeded"] stringByTrimmingCharactersInSet:nonDigits],
                                   @"amountNeededPerTreatment": @500, // Parse properly
                                   @"numberOfTreatmentsFunded": [fundInfo[@"treatmentsFunded"] stringByTrimmingCharactersInSet:nonDigits],
                                   @"numberOfTreatmentsNeeded": @100, // Parse properly
                                   @"numberOfPeopleDonated": @0 // Parse properly
                                   };
            
            NSDictionary *focus = @{
                                    @"name": categoryInfo[@"categoryName"],
                                    @"thumbnailImageUrlString": categoryInfo[@"categoryImage"][@"src"],
                                    @"focusDescription": [categoryInfo[@"categoryDescription"] isKindOfClass:[NSDictionary class]] ?  categoryInfo[@"categoryDescription"][@"text"] : categoryInfo[@"categoryDescription"]
                                    };
            
            NSDictionary *formattedData = @{@"name": doctorInfo[@"name"],
                              @"profileImageUrlString": doctorInfo[@"bannerImage"][@"src"], // Get the real profile image
                              @"tagLine": @"This is my awesome tagline!", // Replace with real tagline if possible
                              @"personalDescription": [doctorInfo[@"description"] isKindOfClass:[NSDictionary class]] ? doctorInfo[@"description"][@"text"] : doctorInfo[@"description"],
                              @"parentOrganization": [doctorInfo[@"parentOrganization"] isKindOfClass:[NSDictionary class]] ? doctorInfo[@"parentOrganization"][@"text"] : @"",
                              @"fund": fund,
                              @"focuses": @[ focus ],
                              @"fullScreenImageUrlString": doctorInfo[@"bannerImage"][@"src"],
                              @"quote": doctorInfo[@"quote"],
                              @"videoUrlString": @"", // Get the video URL String if exists
                              @"humanReadableLocation": doctorInfo[@"location"]
                              };
            
            // NSLog(@"formatted Data: %@", formattedData);
            
            Doctor *doctor = [[Doctor alloc] initWithDictionary:formattedData];
            
            [doctors addObject:doctor];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(doctors, nil);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(nil, error);
        }];
    }];

}

@end
