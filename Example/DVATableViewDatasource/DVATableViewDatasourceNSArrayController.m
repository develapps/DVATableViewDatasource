//
//  DVATableViewDatasourceNSArrayController
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewDatasourceNSArrayController.h"
#import <DVAProtocolDataSourceForTableView.h>
#import <NSArray+DVATableViewModelDatasource.h>
#import "DVATestCellModel.h"
#import "DVATestCellModelTwo.h"
#import "DVATableViewCell.h"
#import "DVATableViewCellTwo.h"

@interface DVATableViewDatasourceNSArrayController ()
@property (nonatomic,strong) DVAProtocolDataSourceForTableView  *datasource;
@property (nonatomic,strong) NSArray                            *viewModelManager;
@end

@implementation DVATableViewDatasourceNSArrayController

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
    _viewModelManager=[NSArray new];
    for (int i=0; i<4; i++) {
        if (i%2==0) {
            DVATestCellModel*cm=[DVATestCellModel new];
            cm.title=[NSString stringWithFormat:@"Cell %i",i];
            _viewModelManager=[_viewModelManager arrayByAddingObject:cm];
        }
        else{
            DVATestCellModelTwo*cm=[DVATestCellModelTwo new];
            cm.title=[NSString stringWithFormat:@"Two %i",i];
            _viewModelManager=[_viewModelManager arrayByAddingObject:cm];
        }
    }
    _datasource.viewModelDataSource=_viewModelManager;
    [_datasource setTitleHeader:@"section 1" ForSection:0];
    [_datasource setTitleHeader:@"section 2" ForSection:1];
}

#pragma mark - Table view data source

-(void)setupDataSource{
    _datasource=[DVAProtocolDataSourceForTableView new];
    self.tableView.dataSource=_datasource;
}

@end

