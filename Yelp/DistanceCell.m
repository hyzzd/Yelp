//
//  DistanceCell.m
//  Yelp
//
//  Created by Neal Wu on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "DistanceCell.h"

@implementation DistanceCell

- (IBAction)segmentChanged:(id)sender {
    [self.delegate distanceCell:self didChangeSegment:self.segmentedControl.selectedSegmentIndex];
}

@end
