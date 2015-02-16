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
@property (readonly, nonatomic) NSDictionary *filters;
@property (strong, nonatomic) NSArray *categories;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        self.categories = @[@{@"name": @"American (Traditional)", @"code": @"newamerican"}, @{@"name": @"Chinese", @"code": @"chinese"}, @{@"name": @"Sushi Bars", @"code": @"sushi"}];
        NSLog(@"Count: %ld", self.categories.count);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld cells", self.categories.count);
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
    cell.on = NO;
    [cell setFilterText:self.categories[indexPath.row][@"name"]];
    cell.delegate = self;
    return cell;
}

#pragma mark - FilterCell delegate methods

- (void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value {

}

#pragma mark - Private methods

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onFilterButton {
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
