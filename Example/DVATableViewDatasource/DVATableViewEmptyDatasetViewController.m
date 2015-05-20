//
//  DVATableViewEmptyDatasetViewController.m
//  DVATableViewDatasource
//
//  Created by Rafa Barberá on 20/05/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewEmptyDatasetViewController.h"
#import "UITableView+Downloading.h"

#import <DVATableViewDatasource/DVAProtocolDataSourceForTableView.h>
#import <DVATableViewDatasource/NSArray+DVATableViewModelDatasource.h>

@interface DVATableViewEmptyDatasetViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DVAProtocolDataSourceForTableView *dataSource;
@end

@implementation DVATableViewEmptyDatasetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DVAProtocolDataSourceForTableView new];
    self.dataSource.noDataView = [self messageViewWithMessage:@"Data not found"];
    self.tableView.dataSource = self.dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView dva_showDownloadProgressIndicator];
    [self longProcess:^(NSArray *data, NSError *error) {
        [self.tableView dva_hideDownloadProgressIndicator];
        self.dataSource.viewModelDataSource = data;
        [self.tableView reloadData];
    }];
}

- (UIView *)messageViewWithMessage:(NSString *)message {
    UIView *background = [UIView new];
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = message;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    label.textColor = [UIColor redColor];
    [background addSubview:label];
    
    NSDictionary *views = @{ @"label" : label };
    [background addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[label]-40-|" options:kNilOptions metrics:nil views:views]];
    [background addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:background attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    return background;
}

- (void)longProcess:(void(^)(NSArray *data, NSError *error))handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            handler([NSArray new], nil);
        });
    });
}

@end
