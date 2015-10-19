//
//  DVATableViewUpdate.m
//  TableViewTesting
//
//  Created by Pablo Romeu on 30/9/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewUpdate.h"

@interface DVATableViewUpdate ()
@property (nonatomic)       DVATableViewUpdateType     type;
@property (nonatomic,copy)  NSIndexPath                     *indexPath;
@property (nonatomic,copy)  NSIndexPath                     *otherIndexPath;
@end

@implementation DVATableViewUpdate

- (instancetype)initWithType:(DVATableViewUpdateType)type
                   indexPath:(NSIndexPath *)ip
              otherIndexPath:(NSIndexPath *)otherIp
{
    self = [super init];
    if (self) {
        self.type = type;
        self.indexPath = ip;
        self.otherIndexPath = otherIp;

    }
    return self;
}


-(DVATableViewUpdateType)dva_updateType{
    return self.type;
}
-(NSIndexPath *)dva_indexPath{
    return self.indexPath;
}

-(NSIndexPath *)dva_toIndexPath{
    return self.otherIndexPath;
}
@end