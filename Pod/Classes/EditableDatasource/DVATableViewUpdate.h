//
//  DVATableViewUpdate
//
//  Created by Pablo Romeu on 30/9/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DVATableViewUpdateTypeInsert,
    DVATableViewUpdateTypeUpdate,
    DVATableViewUpdateTypeMove,
    DVATableViewUpdateTypeDelete,
} DVATableViewUpdateType;

@interface DVATableViewUpdate : NSObject
- (instancetype)initWithType:(DVATableViewUpdateType)type
                   indexPath:(NSIndexPath *)ip
              otherIndexPath:(NSIndexPath *)otherIp;
-(DVATableViewUpdateType)dva_updateType;
-(NSIndexPath*)dva_indexPath;
-(NSIndexPath*)dva_toIndexPath;
@end
