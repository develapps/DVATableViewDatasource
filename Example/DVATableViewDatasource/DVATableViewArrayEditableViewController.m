//
//  DVATableViewArrayEditableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 19/10/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewArrayEditableViewController.h"

#import "DVATableDatasourceMutableArray.h"
#import "DVAProtocolDatasourceForTableView.h"

#import "CustomDatasourceCell.h"
#import "CellEntityMapper.h"

@interface DVATableViewArrayEditableViewController () <UITableViewDelegate>
@property (nonatomic,strong) DVATableDatasourceMutableArray         *viewModelDatasource;
@property (nonatomic,strong) DVAProtocolDataSourceForTableView      *dataSource;
@property (nonatomic,weak)   IBOutlet UITableView                   *tableView;
@property (nonatomic)        BOOL                                   grouped;

@end

@implementation DVATableViewArrayEditableViewController

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
    self.viewModelDatasource = [[DVATableDatasourceMutableArray alloc] initWithTableView:self.tableView];
    self.dataSource.viewModelDataSource = self.viewModelDatasource;
    [self.viewModelDatasource setDebug:YES];
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
    
    void (^updates)(void) = ^void(void) {
        // Insert
        CellEntityMapper *cellVM=[[CellEntityMapper alloc] init];
        cellVM.title = @"INSERTED CELL";
        [self.viewModelDatasource insertObject:cellVM atIndex:0];
        
        // Delete
        [self.viewModelDatasource removeObjectAtIndex:2];
        
        // Update
        cellVM=[[CellEntityMapper alloc] init];
        cellVM.title = @"UPDATED CELL";
        [self.viewModelDatasource replaceObjectAtIndex:1 withObject:cellVM];
        
    };
    
    
    if (_grouped) {
        [self.viewModelDatasource dva_performUpdates:^{
            updates();
        } withCompletionBlock:^(BOOL finished) {
            NSLog(@"done block updates!");
        }];
    }
    else{
        updates();
    }
    _grouped = !_grouped;
}

-(void)setupCells{
    for (int j=0; j<1; j++) {
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
