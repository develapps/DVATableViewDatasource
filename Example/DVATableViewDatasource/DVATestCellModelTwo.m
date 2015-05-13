//
//  DVATestCellModelTwo.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATestCellModelTwo.h"
#import "DVATableViewCellTwo.h"

@implementation DVATestCellModelTwo


-(NSString*)dva_cellIdentifier{
    return [DVATableViewCellTwo description];
}

@end