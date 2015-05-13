//
//  DVATableViewCellTwo.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCellTwo.h"
#import "DVATestCellModel.h"

@implementation DVATableViewCellTwo

-(void)bindWithModel:(id)viewModel{
    DVATestCellModel*model=viewModel;
    [self.theLabel setText:model.title];
    [self.contentView setBackgroundColor:[UIColor blueColor]];
}

@end