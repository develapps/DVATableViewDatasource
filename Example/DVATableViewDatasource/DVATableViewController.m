//
//  DVATableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewController.h"
#import <DVAArrayDataSourceForTableView.h>

@interface DVATableViewController ()
@property (nonatomic,strong) DVAArrayDataSourceForTableView *datasource;
@property (nonatomic,strong) DVATableViewControllerModel    *viewModel;
@end

@implementation DVATableViewController

- (void)viewDidLoad { 
    [super viewDidLoad];
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    self.viewModel=[DVATableViewControllerModel new];
}

#pragma mark - Table view data source

-(void)setupDataSource{
    self.datasource=[DVAArrayDataSourceForTableView new];
    [self.datasource registercellIdentifier:@"Cell" cellConfiguration:^(id item, id cell, NSIndexPath *indexPath) {
        // Any configuration code you need.
    }];
}

@end

@implementation DVATableViewControllerModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        <#statements#>
    }
    return self;
}

@end