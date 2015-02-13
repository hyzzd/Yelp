//
//  RestaurantViewCell.m
//  Yelp
//
//  Created by Neal Wu on 2/11/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "RestaurantViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface RestaurantViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation RestaurantViewCell

- (void)setBusinessData:(NSDictionary *)businessData {
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:businessData[@"image_url"]]];
    self.nameLabel.text = businessData[@"name"];
}

@end
