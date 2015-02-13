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

NSString * const kYelpConsumerKey = @"-6pfJLti5emvMGEXT_KCHw";
NSString * const kYelpConsumerSecret = @"jldy5n1-aFH8oT6kUPaFt-nlXYI";
NSString * const kYelpToken = @"vIicZYAsuZJZWGtfNKPP_F9SOyB1AE-0";
NSString * const kYelpTokenSecret = @"fcCaYeNRmUvYB7uZ7--23v72lG4";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) YelpClient *client;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSArray *businesses;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    UINib *restaurantViewCellNib = [UINib nibWithNibName:@"RestaurantViewCell" bundle:nil];
    [self.tableView registerNib:restaurantViewCellNib forCellReuseIdentifier:@"RestaurantViewCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        self.data = response;
        self.businesses = [Business businessesWithDictionaries:self.data[@"businesses"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantViewCell" forIndexPath:indexPath];
    [cell setBusinessData:self.businesses[indexPath.row]];
    return cell;
}

@end
