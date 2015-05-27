//
//  NSDictionary+DVATableViewModelProtocol.h
//  liveAppMockup
//
//  Created by Pablo Romeu on 19/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DVATableViewDatasource/DVATableViewModelProtocol.h>
/**
 @author Pablo Romeu, 15-05-27 09:05:57
 
 This class enables you to use a plain NSDictionary (instead of viewModel objects) to create a tableView using
 the DVATableViewModelProtocol.
 
 You just have to include a "dva_cellIdentifier" class. Example:
    
    
 
 @since 1.0
 */
@interface NSDictionary (DVATableViewModelProtocol) <DVATableViewModelProtocol>

@end
