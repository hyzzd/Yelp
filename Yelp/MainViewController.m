//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "SVProgressHUD.h"
#import "FiltersViewController.h"

NSString * const kYelpConsumerKey = @"-6pfJLti5emvMGEXT_KCHw";
NSString * const kYelpConsumerSecret = @"jldy5n1-aFH8oT6kUPaFt-nlXYI";
NSString * const kYelpToken = @"vIicZYAsuZJZWGtfNKPP_F9SOyB1AE-0";
NSString * const kYelpTokenSecret = @"fcCaYeNRmUvYB7uZ7--23v72lG4";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) YelpClient *client;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSArray *businesses;

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSString *searchText;

@end

@implementation MainViewController

- (void)searchForTerm:(NSString *)term withParams:(NSDictionary *)params {
    [SVProgressHUD showWithStatus:@"Loading..."];

    [self.client searchWithTerm:term withParams:params success:^(AFHTTPRequestOperation *operation, id response) {
        self.data = response;
        self.businesses = [Business businessesWithDictionaries:self.data[@"businesses"]];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
        [SVProgressHUD dismiss];
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        [self doSearch:@"Food"];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Yelp";

    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(onSearchButton)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

// Note: this is a bit of a hack to fix a UI bug where the table cells get squished after coming back from the FiltersViewController.
- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell" forIndexPath:indexPath];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

#pragma mark - FiltersViewController delegate methods

- (void)filtersViewController:(FiltersViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters {
    [self searchForTerm:self.searchText withParams:filters];
}

#pragma mark - Private methods

- (void)doSearch:(NSString *)searchText {
    self.searchText = searchText;
    [self searchForTerm:self.searchText withParams:nil];
}

- (void)onFilterButton {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)onSearchButton {
    [self doSearch:self.searchBar.text];
}

@end
