//
//  FilterCell.m
//  Yelp
//
//  Created by Neal Wu on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell ()

@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;

- (IBAction)switchValueChanged:(id)sender;

@end

@implementation FilterCell

@synthesize on = _on;

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate filterCell:self didChangeValue:self.filterSwitch.on];
}

- (BOOL)on {
    return self.filterSwitch.on;
}

- (void)setOn:(BOOL)on {
    _on = on;
    self.filterSwitch.on = on;
}

- (void)setFilterText:(NSString *)text {
    self.filterLabel.text = text;
}

@end
