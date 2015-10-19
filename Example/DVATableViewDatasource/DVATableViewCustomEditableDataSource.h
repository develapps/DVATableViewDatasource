//
//  DVATableViewCustomEditableDataSource.h
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 19/10/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DVATableViewModelEditableDatasource.h"
#import "DVATableViewEditManager.h"
@interface DVATableViewCustomEditableDataSource : NSObject <DVATableViewModelEditableDatasource>
-(instancetype)initWithAnimationEditor:(DVATableViewEditManager*)manager;
@property (nonatomic,strong,readonly)   NSMutableArray    *viewModelArray;
-(void)tappedButton;
@end
