//
//  SegmentedCell.m
//  Yelp
//
//  Created by Neal Wu on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "SortCell.h"

@implementation SortCell

- (IBAction)segmentChanged:(id)sender {
    [self.delegate sortCell:self didChangeSegment:self.segmentedControl.selectedSegmentIndex];
}

@end
