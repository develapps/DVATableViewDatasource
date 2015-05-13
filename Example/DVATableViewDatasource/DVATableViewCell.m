//
//  DVATableViewCell.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCell.h"
#import "DVATestCellModel.h"

@implementation DVATableViewCell


-(void)bindWithModel:(id)viewModel{
    DVATestCellModel*model=viewModel;
    [self.theLabel setText:model.title];
}
@end
