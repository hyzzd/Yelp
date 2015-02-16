//
//  Business.h
//  Yelp
//
//  Created by Neal Wu on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (strong, nonatomic) NSString *thumbImageUrl;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ratingImageUrl;
@property (assign, nonatomic) NSInteger numReviews;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *categories;
@property (assign, nonatomic) float distance;

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries;

@end
