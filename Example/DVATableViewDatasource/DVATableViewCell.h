//
//  DVATableViewCell.h
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DVATableViewConfigurableCellProtocol.h>

@interface DVATableViewCell : UITableViewCell <DVATableViewConfigurableCellProtocol>
@property (weak, nonatomic) IBOutlet UILabel *theLabel;

@end
