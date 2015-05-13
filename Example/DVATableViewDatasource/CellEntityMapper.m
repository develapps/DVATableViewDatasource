//
//  CellEntityMapper.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 13/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "CellEntityMapper.h"

@implementation CellEntityMapper
+(CellEntityMapper*)cellEntityMapperWithCellEntity:(CellEntity*)entity{
    CellEntityMapper*mapper=[CellEntityMapper new];
    mapper.title=entity.title;
    mapper.section=entity.section;
    mapper.subTitle=entity.subTitle;
    return mapper;
}
-(NSString *)dva_cellIdentifier{
    return @"CustomDatasourceCell";
}
@end
