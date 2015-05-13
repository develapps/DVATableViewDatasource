//
//  DVATableViewCellModel.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATestCellModel.h"
#import "DVATableViewCell.h"

@implementation DVATestCellModel

-(NSString*)dva_cellIdentifier{
    return [DVATableViewCell description];
}

@end
