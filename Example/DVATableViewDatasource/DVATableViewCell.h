//
//  DVATableViewCell.h
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DVATableViewCellProtocol.h>
#import "DVATableViewActionDelegate.h"

@interface DVATableViewCell : UITableViewCell <DVATableViewCellProtocol>
@property (nonatomic,weak) id <DVATableViewActionDelegate> delegate;
@property (nonatomic) NSInteger * identifier;
@end
