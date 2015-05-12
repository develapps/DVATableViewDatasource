//
//  NSDictionary+DVAViewModelDatasource.h
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import <Foundation/Foundation.h>
#import "DVAViewModelDataSourceProtocol.h"

/**
 @author Pablo Romeu, 15-05-12 17:05:30
 
 Helper to use dictionaries as DVAViewModelDataSourceProtocol
 
 @since 1.1.0
 */
@interface NSDictionary (DVAViewModelDatasource) <DVAViewModelDataSourceProtocol>

@end
