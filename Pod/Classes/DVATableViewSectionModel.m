//
//  DVATableViewSectionModel.m
//  AquaService
//
//  Created by Pablo Romeu on 27/3/15.
//  Copyright (c) 2015 Develapps. All rights reserved.
//

#import "DVATableViewSectionModel.h"

@implementation DVATableViewSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cells=@[];
    }
    return self;
}

#pragma mark - description

-(NSString*)description{
    __block NSString*str=@"";
    [self.cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        str=[str stringByAppendingFormat:@"CELL %lu: %@\n",(unsigned long)idx,obj];
    }];
    return str;
}

#pragma mark - accesors

-(DVATableViewCellModel*)cellAtIndex:(NSInteger)index{
    if (index<[self.cells count]) {
        return [self.cells objectAtIndex:index];
    }
    return nil;
}

-(void)setCell:(DVATableViewCellModel *)cell atIndex:(NSInteger)index{
    NSMutableArray*cells=[self.cells mutableCopy];
    if (index<=[self.cells count]) {
        [cells insertObject:cell atIndex:index];
    }
}

@end
