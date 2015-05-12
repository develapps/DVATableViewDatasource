//
//  DVATestCellModelTwo.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATestCellModelTwo.h"


@interface DVATestCellModelTwo ()
{
    NSString*_identifier;
}
@end

@implementation DVATestCellModelTwo

-(void)setDva_cellIdentifier:(NSString *)dva_cellIdentifier{
    _identifier=[dva_cellIdentifier copy];
}

-(NSString*)dva_cellIdentifier{
    return _identifier;
}

@end