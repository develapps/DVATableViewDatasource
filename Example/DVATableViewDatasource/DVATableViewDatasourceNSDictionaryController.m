//
//  DVATableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewDatasourceNSDictionaryController.h"
#import <DVAProtocolDataSourceForTableView.h>
#import <NSDictionary+DVATableViewModelDatasource.h>
#import "DVATestCellModel.h"
#import "DVATableViewCell.h"

@interface DVATableViewDatasourceNSDictionaryController () <DVATableViewActionDelegate,DVATableViewModelDatasourceDelegate>
@property (nonatomic,strong) DVAProtocolDataSourceForTableView  *datasource;
@property (nonatomic,strong) NSDictionary                       *viewModelManager;
@end

@implementation DVATableViewDatasourceNSDictionaryController

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
    for (int i=0; i<6; i++) {
        DVATestCellModel*cm=[DVATestCellModel new];
        cm.title=[NSString stringWithFormat:@"Cell %i",i];
        tmp=[tmp arrayByAddingObject:cm];
    }
    NSArray*tmp2=[NSArray new];
    for (int i=0; i<40; i++) {
        DVATestCellModel*cm=[DVATestCellModel new];
        cm.title=[NSString stringWithFormat:@"Cell %i",i];
        tmp2=[tmp2 arrayByAddingObject:cm];
    }

    _viewModelManager=@{@(0):tmp,
                        @(1):tmp2};
    _datasource.viewModelDataSource=_viewModelManager;
    _datasource.delegate=self;
    [_datasource setTitleHeader:@"section 1" ForSection:0];
    [_datasource setTitleHeader:@"section 2" ForSection:1];
}

#pragma mark - Table view data source

-(void)setupDataSource{
    _datasource=[DVAProtocolDataSourceForTableView new];
    self.tableView.dataSource=_datasource;
}

#pragma mark - TableViewDataSource Delegate

-(void)dataSource:(id<DVATableViewModelDatasource>)datasource postBindCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[DVATableViewCell class]]) {
        DVATableViewCell*aCell=(DVATableViewCell*)cell;
        [aCell.contentView setBackgroundColor:indexPath.row%2==0?[UIColor redColor]:[UIColor blueColor]];
        aCell.delegate=self;
    }
}

#pragma mark - Actions

-(void)cell:(UITableViewCell *)cell switchDidSwitch:(UISwitch *)aSwitch{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"Cell switched"
                                                                message:[NSString stringWithFormat:@"Cell %@ switched to %i",cell,aSwitch.isOn]
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end



