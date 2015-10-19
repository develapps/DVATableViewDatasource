//
//  DVATableViewSectionArrayEditableViewController.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 19/10/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewSectionArrayEditableViewController.h"

#import "DVATableDatasourceSectionMutableArray.h"
#import "DVAProtocolDatasourceForTableView.h"

#import "CustomDatasourceCell.h"
#import "CellEntityMapper.h"

@interface DVATableViewSectionArrayEditableViewController () <UITableViewDelegate>
@property (nonatomic,strong) DVATableDatasourceSectionMutableArray  *viewModelDatasource;
@property (nonatomic,strong) DVAProtocolDataSourceForTableView      *dataSource;
@property (nonatomic,weak)   IBOutlet UITableView                   *tableView;
@property (nonatomic)        BOOL                                   grouped;

@end

@implementation DVATableViewSectionArrayEditableViewController

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
    self.viewModelDatasource = [[DVATableDatasourceSectionMutableArray alloc] initWithTableView:self.tableView];
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
    
    void (^animationsBlock)(NSUInteger rand) = ^void(NSUInteger rand) {
        
        // Remove section 3
        
        [self.viewModelDatasource removeObjectAtIndex:3];
        
        // Add section 2
        
        NSMutableArray *viewModels = [NSMutableArray new];
        for (int i = 0; i<rand; i++) {
            CellEntityMapper *cellVM=[[CellEntityMapper alloc] init ];
            [cellVM setTitle:[NSString stringWithFormat:@"Added section Row %zd",i]];
            [cellVM setSubTitle:[NSString stringWithFormat:@"Section %zd",2]];
            [viewModels addObject:cellVM];
        }
        [self.viewModelDatasource insertObject:viewModels atIndex:2];
        
        
        // Rows modification at section 1
        NSUInteger count = [self.viewModelDatasource dva_numberOfViewModelsInSection:1];
        for (int i = 0; i<count/2; i++) {
            [self.viewModelDatasource dva_removeObjectAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
        }
        
        for (int i = 0; i<rand; i++) {
            CellEntityMapper *cellVM=[[CellEntityMapper alloc] init ];
            [cellVM setTitle:[NSString stringWithFormat:@"Added Row %zd",i]];
            [self.viewModelDatasource dva_addObject:cellVM atSection:1];
        }
    };
    
    NSUInteger rand = 1+arc4random_uniform(4);
    if (_grouped) {
        [self.viewModelDatasource dva_performUpdates:^{
            animationsBlock(rand);
        } withCompletionBlock:^(BOOL finished) {
            NSLog(@"Done!");
        }];
    }
    else{
        animationsBlock(rand);
    }
    _grouped=!_grouped;
}

-(void)setupCells{
    for (int j=0; j<4; j++) {
        for (int i=0; i<4; i++ ) {
            CellEntityMapper *cellVM = [CellEntityMapper new];
            cellVM.title =[NSString stringWithFormat:@"Cell %zd",i];
            cellVM.subTitle = [NSString stringWithFormat:@"Section %zd",j];
            [self.viewModelDatasource dva_addObject:cellVM atSection:j];
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
