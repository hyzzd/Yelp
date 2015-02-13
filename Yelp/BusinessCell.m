//
//  BusinessCell.m
//  Yelp
//
//  Created by Neal Wu on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation BusinessCell

- (void)awakeFromNib {
    self.thumbImageView.layer.cornerRadius = 3;
    self.thumbImageView.clipsToBounds = YES;
}

- (void)setBusiness:(Business *)business {
    _business = business;

    [self.thumbImageView setImageWithURL:[NSURL URLWithString:business.thumbImageUrl]];
    self.nameLabel.text = business.name;
    [self.ratingImageView setImageWithURL:[NSURL URLWithString:business.ratingImageUrl]];
    self.reviewsLabel.text = [NSString stringWithFormat:@"%ld Reviews", (long) business.numReviews];
    self.addressLabel.text = business.address;
    self.categoryLabel.text = business.categories;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", business.distance];
}

@end
