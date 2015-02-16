//
//  FiltersViewController.m
//  Yelp
//
//  Created by Neal Wu on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "FilterCell.h"
#import "SortCell.h"
#import "DistanceCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SortCellDelegate, DistanceCellDelegate, FilterCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@property (assign, nonatomic) NSInteger sortSelection;
@property (assign, nonatomic) NSInteger distanceSelection;
@property (assign, nonatomic) BOOL dealsFilter;
@property (strong, nonatomic) NSMutableArray *categoryOn;

@end

@implementation FiltersViewController

static const float MILES_PER_METER = 0.000621371192;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        self.categories = @[@{@"name": @"American (New)", @"code": @"newamerican"},
                            @{@"name": @"American (Traditional)", @"code": @"tradamerican"},
                            @{@"name": @"Asian Fusion", @"code": @"asianfusion"},
                            @{@"name": @"Barbeque", @"code": @"bbq"},
                            @{@"name": @"Bars", @"code": @"bars"},
                            @{@"name": @"Breakfast & Brunch", @"code": @"breakfast_brunch"},
                            @{@"name": @"Burgers", @"code": @"burgers"},
                            @{@"name": @"Chinese", @"code": @"chinese"},
                            @{@"name": @"Fast Food", @"code": @"hotdogs"},
                            @{@"name": @"Indian", @"code": @"indpak"},
                            @{@"name": @"Japanese", @"code": @"japanese"},
                            @{@"name": @"Korean", @"code": @"korean"},
                            @{@"name": @"Latin American", @"code": @"latin"},
                            @{@"name": @"Mexican", @"code": @"mexican"},
                            @{@"name": @"Pizza", @"code": @"pizza"},
                            @{@"name": @"Sandwiches", @"code": @"sandwiches"},
                            @{@"name": @"Seafood", @"code": @"seafood"},
                            @{@"name": @"Sushi Bars", @"code": @"sushi"},
                            @{@"name": @"Thai", @"code": @"thai"},
                            @{@"name": @"Vietnamese", @"code": @"vietnamese"}];

        self.categoryOn = [NSMutableArray array];

        for (int i = 0; i < self.categories.count; i++) {
            [self.categoryOn addObject:@(NO)];
        }

        self.sortSelection = 0;
        self.distanceSelection = 0;
        self.dealsFilter = NO;
        [self.tableView reloadData];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(onFilterButton)];

    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SortCell" bundle:nil] forCellReuseIdentifier:@"SortCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DistanceCell" bundle:nil] forCellReuseIdentifier:@"DistanceCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];

//    self.tableView.sectionHeaderHeight = 35;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Sort";
    } else if (section == 1) {
        return @"Distance";
    } else if (section == 2) {
        return @"Deals";
    } else {
        return @"Categories";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        return 1;
    } else {
        return self.categories.count;
    }
}

- (void)styleTableCell:(UITableViewCell *)cell {
//    [cell.contentView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
//    [cell.contentView.layer setBorderWidth:1.0];
//    cell.contentView.layer.cornerRadius = 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;

    if (section == 0) {
        SortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SortCell" forIndexPath:indexPath];
        cell.segmentedControl.selectedSegmentIndex = self.sortSelection;
        cell.delegate = self;
        [self styleTableCell:cell];
        return cell;
    } else if (section == 1) {
        DistanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DistanceCell" forIndexPath:indexPath];
        cell.segmentedControl.selectedSegmentIndex = self.distanceSelection;
        cell.delegate = self;
        [self styleTableCell:cell];
        return cell;
    } else if (section == 2) {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        [cell setFilterText:@"Offering a Deal"];
        cell.on = self.dealsFilter;
        cell.delegate = self;
        [self styleTableCell:cell];
        return cell;
    } else {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        [cell setFilterText:self.categories[indexPath.row][@"name"]];
        cell.on = [self.categoryOn[indexPath.row] boolValue];
        cell.delegate = self;
        [self styleTableCell:cell];
        return cell;
    }
}

#pragma mark - SortCell delegate methods

- (void)sortCell:(SortCell *)sortCell didChangeSegment:(NSInteger)segment {
    self.sortSelection = segment;
}

#pragma mark - DistanceCell delegate methods

- (void)distanceCell:(DistanceCell *)cell didChangeSegment:(NSInteger)segment {
    self.distanceSelection = segment;
}

#pragma mark - FilterCell delegate methods

- (void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:filterCell];
    NSInteger section = indexPath.section;

    if (section == 2) {
        self.dealsFilter = value;
    } else {
        self.categoryOn[indexPath.row] = @(value);
    }
}

#pragma mark - Private methods

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onFilterButton {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    [filters setObject:[NSString stringWithFormat:@"%ld", self.sortSelection] forKey:@"sort"];

    if (self.distanceSelection > 0) {
        float distanceInMiles = [@[@(0.0), @(0.3), @(1.0), @(5.0)][self.distanceSelection] floatValue];
        float distanceInMeters = distanceInMiles / MILES_PER_METER;
        [filters setObject:[NSString stringWithFormat:@"%.0f", distanceInMeters] forKey:@"radius_filter"];
    }

    if (self.dealsFilter) {
        [filters setObject:@"1" forKey:@"deals_filter"];
    }

    NSMutableArray *categoryCodes = [NSMutableArray array];

    for (int i = 0; i < self.categories.count; i++) {
        if ([self.categoryOn[i] boolValue]) {
            [categoryCodes addObject:self.categories[i][@"code"]];
        }
    }

    if (categoryCodes.count > 0) {
        NSString *categoryString = [categoryCodes componentsJoinedByString:@","];
        [filters setObject:categoryString forKey:@"category_filter"];
    }

    [self.delegate filtersViewController:self didChangeFilters:filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
