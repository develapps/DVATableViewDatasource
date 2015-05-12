//
//  DVATableViewCellTwo.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCellTwo.h"
#import "DVATestCellModel.h"

@interface DVATableViewCellTwo ()
{
    DVATestCellModel * _viewModel;
}
@end

@implementation DVATableViewCellTwo

-(id)viewModel{
    return _viewModel;
}

-(void)setViewModel:(id)viewModel{
    _viewModel=(DVATestCellModel*)viewModel;
    [self.contentView setBackgroundColor:[UIColor blueColor]];
    [self.theLabel setText:_viewModel.title];
}
@end