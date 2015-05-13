//
//  CustomDatasourceCell.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 13/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "CustomDatasourceCell.h"
#import "CellEntityMapper.h"

@interface CustomDatasourceCell ()
@property (nonatomic,weak) IBOutlet UILabel*theLabel;
@property (nonatomic,weak) IBOutlet UILabel*theSubtitle;
@end

@implementation CustomDatasourceCell


-(void)bindWithModel:(id)viewModel{
    CellEntityMapper*model=viewModel;
    [self.theLabel      setText:model.title];
    [self.theSubtitle   setText:model.subTitle];
}

@end
