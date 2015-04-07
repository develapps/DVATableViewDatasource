//
//  DVATableViewModel.m
//  AquaService
//
//  Created by Pablo Romeu on 27/3/15.
//  Copyright (c) 2015 Develapps. All rights reserved.
//

#import "DVATableViewModel.h"


@implementation DVATableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellConfigurationBlocks=[NSMutableDictionary new];
        _sections=@[];
    }
    return self;
}

#pragma mark - description

-(NSString*)description{
    __block NSString*str=@"\n";
    [self.sections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        str=[str stringByAppendingFormat:@"SECTION %lu: %@\n",(unsigned long)idx,obj];
    }];

    return str;
}

#pragma mark - Indexpath Accessors

-(DVATableViewCellModel*)cellModelForIndexPath:(NSIndexPath *)indexPath{
    DVATableViewSectionModel*section=[self.sections objectAtIndex:indexPath.section];
    return [section cellAtIndex:indexPath.row];
}

-(void)setCellModel:(DVATableViewCellModel*)cell forIndexPath:(NSIndexPath *)indexPath{
    DVATableViewSectionModel*section=[self.sections objectAtIndex:indexPath.section];
    [section setCell:cell atIndex:indexPath.row];
}

@end
