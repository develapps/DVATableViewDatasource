//
//  DVATableViewCell.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCell.h"
#import "DVATestCellModel.h"

@interface DVATableViewCell ()
{
    DVATestCellModel * _viewModel;
}
@end

@implementation DVATableViewCell

-(id)viewModel{
    return _viewModel;
}

-(void)setViewModel:(id)viewModel{
    _viewModel=(DVATestCellModel*)viewModel;
    [self.theLabel setText:_viewModel.title];
}
@end
