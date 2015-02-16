//
//  FiltersViewController.m
//  Yelp
//
//  Created by Neal Wu on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "FilterCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, FilterCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@property (assign, nonatomic) BOOL dealsFilter;
@property (strong, nonatomic) NSMutableArray *categoryOn;

@end

@implementation FiltersViewController

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

        self.dealsFilter = NO;
        [self.tableView reloadData];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(onFilterButton)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;

    if (section == 0) {
        return [[UITableViewCell alloc] init];
    } else if (section == 1) {
        return [[UITableViewCell alloc] init];
    } else if (section == 2) {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        [cell setFilterText:@"Offering a Deal"];
        cell.on = self.dealsFilter;
        cell.delegate = self;
        return cell;
    } else {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        [cell setFilterText:self.categories[indexPath.row][@"name"]];
        cell.on = [self.categoryOn[indexPath.row] boolValue];
        cell.delegate = self;
        return cell;
    }
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
    NSMutableArray *categoryCodes = [NSMutableArray array];

    if (self.categories.count > 0) {
        for (int i = 0; i < self.categories.count; i++) {
            if ([self.categoryOn[i] boolValue]) {
                [categoryCodes addObject:self.categories[i][@"code"]];
            }
        }

        NSString *categoryString = [categoryCodes componentsJoinedByString:@","];
        [filters setObject:categoryString forKey:@"category_filter"];
    }

    if (self.dealsFilter) {
        [filters setObject:@"1" forKey:@"deals_filter"];
    }

    [self.delegate filtersViewController:self didChangeFilters:filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
