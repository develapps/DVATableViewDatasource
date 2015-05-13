//
//  DVATableViewCellModel.h
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DVATableViewModelProtocol.h>

@interface DVATestCellModel : NSObject <DVATableViewModelProtocol>
@property (nonatomic,strong) NSString*title;

@end
