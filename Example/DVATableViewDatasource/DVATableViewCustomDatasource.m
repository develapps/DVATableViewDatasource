//
//  DVATableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCustomDatasource.h"
#import <DVAProtocolDataSourceForTableView.h>
#import "DVACustomDatasource.h"
#import "CustomDatasourceCell.h"
#import "CellEntityMapper.h"

@interface DVATableViewCustomDatasource () <DVATableViewModelDatasourceDelegate>
@property (nonatomic,strong) DVAProtocolDataSourceForTableView  *datasource;
@property (nonatomic,strong) DVACustomDatasource                *viewModelManager;
@end

@implementation DVATableViewCustomDatasource

- (void)viewDidLoad { 
    [super viewDidLoad];
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _datasource.viewModelDataSource=_viewModelManager;
}

#pragma mark - Table view data source

-(void)setupDataSource{
    self.viewModelManager=[DVACustomDatasource new];
    _datasource=[DVAProtocolDataSourceForTableView new];
    self.tableView.dataSource=_datasource;
}

#pragma mark - TableViewDataSource Delegate

-(void)dataSource:(id<DVATableViewModelDatasource>)datasource postBindCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[CustomDatasourceCell class]]) {
        CustomDatasourceCell*aCell=(CustomDatasourceCell*)cell;
        [aCell.contentView setBackgroundColor:indexPath.row%2==0?[UIColor redColor]:[UIColor blueColor]];
    }
}
@end



