//
//  DVATableViewCellModel.m
//  AquaService
//
//  Created by Pablo Romeu on 27/3/15.
//  Copyright (c) 2015 Develapps. All rights reserved.
//

#import "DVATableViewCellModel.h"

@implementation DVATableViewCellModel

-(NSString*)description{
    return [NSString stringWithFormat:@"%@: identifier: %@, CELL: %@",[self.class description],self.cellIdentifier,self];
}

@end
