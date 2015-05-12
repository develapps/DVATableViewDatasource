//
//  DVATableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewController.h"
#import <DVAArrayDataSourceForTableView.h>
#import <NSDictionary+DVAViewModelDatasource.h>
#import "DVATestCellModel.h"
#import "DVATestCellModelTwo.h"
#import "DVATableViewCell.h"
#import "DVATableViewCellTwo.h"

@interface DVATableViewController ()
@property (nonatomic,strong) DVAArrayDataSourceForTableView *datasource;
@property (nonatomic,strong) NSDictionary                   *viewModelManager;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _viewModelManager=[NSDictionary new];
    NSArray*tmp=[NSArray new];
    for (int i=0; i<10; i++) {
        if (i%2==0) {
            DVATestCellModel*cm=[DVATestCellModel new];
            cm.title=[NSString stringWithFormat:@"Cell %i",i];
            cm.dva_cellIdentifier=[DVATableViewCell description];
            tmp=[tmp arrayByAddingObject:cm];
        }
        else{
            DVATestCellModelTwo*cm=[DVATestCellModelTwo new];
            cm.title=[NSString stringWithFormat:@"Two %i",i];
            cm.dva_cellIdentifier=[DVATableViewCellTwo description];
            tmp=[tmp arrayByAddingObject:cm];
        }
    }
    NSArray*tmp2=[NSArray new];
    for (int i=0; i<1000; i++) {
        if (i%2==0) {
            DVATestCellModel*cm=[DVATestCellModel new];
            cm.title=[NSString stringWithFormat:@"Cell %i",i];
            cm.dva_cellIdentifier=[DVATableViewCell description];
            tmp2=[tmp2 arrayByAddingObject:cm];
        }
        else{
            DVATestCellModelTwo*cm=[DVATestCellModelTwo new];
            cm.title=[NSString stringWithFormat:@"Two %i",i];
            cm.dva_cellIdentifier=[DVATableViewCellTwo description];
            tmp2=[tmp2 arrayByAddingObject:cm];
        }

    }

    _viewModelManager=@{@(0):tmp,
                        @(1):tmp2};
    _datasource.viewModelDataSource=_viewModelManager;
    [_datasource setTitleHeader:@"seccion 1" ForSection:0];
}

#pragma mark - Table view data source

-(void)setupDataSource{
    _datasource=[DVAArrayDataSourceForTableView new];
    self.tableView.dataSource=_datasource;
}

@end

