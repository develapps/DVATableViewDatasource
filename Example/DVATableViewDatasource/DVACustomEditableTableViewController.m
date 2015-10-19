//
//  DVACustomEditableTableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 19/10/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVACustomEditableTableViewController.h"

#import "DVATableViewCustomEditableDataSource.h"
#import "DVAProtocolDatasourceForTableView.h"

#import "CustomDatasourceCell.h"
#import "CellEntityMapper.h"

@interface DVACustomEditableTableViewController () <UITableViewDelegate>
@property (nonatomic,strong) DVATableViewEditManager                *manager;
@property (nonatomic,strong) DVATableViewCustomEditableDataSource   *viewModelDatasource;
@property (nonatomic,strong) DVAProtocolDataSourceForTableView      *dataSource;
@property (nonatomic,weak)   IBOutlet UITableView                   *tableView;

@end

@implementation DVACustomEditableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatasource];
    [self setupButtons];
    [self setupCells];
    
}

-(void)setupDatasource{
    self.dataSource = [[DVAProtocolDataSourceForTableView alloc] init];
    [self.tableView setDataSource:self.dataSource];
    [self.tableView setDelegate:self];

    DVATableViewEditManager *manager = [[DVATableViewEditManager alloc] initWithTableView:self.tableView];
    self.viewModelDatasource = [[DVATableViewCustomEditableDataSource alloc] initWithAnimationEditor:manager];
    self.dataSource.viewModelDataSource = self.viewModelDatasource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupButtons{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tappedButton:)];
    [self.navigationItem setRightBarButtonItem:item];
}

-(void)tappedButton:(UIBarButtonItem*)button{
    [self.viewModelDatasource tappedButton];
}

-(void)setupCells{
    for (int j=0; j<4; j++) {
        for (int i=0; i<4; i++ ) {
            CellEntityMapper *cellVM = [CellEntityMapper new];
            cellVM.title =[NSString stringWithFormat:@"Cell %zd",i];
            cellVM.subTitle = [NSString stringWithFormat:@"Section %zd",j];
            [self.viewModelDatasource dva_insertViewModel:cellVM
                                              atIndexPath:[NSIndexPath indexPathForItem:i inSection:j]];
        }
        
    }

}

#pragma mark - TableViewDataSource Delegate

-(void)dataSource:(id<DVATableViewModelDatasource>)datasource postBindCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[CustomDatasourceCell class]]) {
        CustomDatasourceCell*aCell=(CustomDatasourceCell*)cell;
        [aCell.contentView setBackgroundColor:indexPath.row%2==0?[UIColor redColor]:[UIColor blueColor]];
    }
}


@end
