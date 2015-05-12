//
//  DVATableViewCellIdentifierProtocol.h
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//
#import <Foundation/Foundation.h>

/**
 @author Pablo Romeu, 15-05-12 09:05:34
 
 This protocol states a method returned by an viewModel object that can respond to the type of cell needed by `DVAArrayDataSourceForTableView`.
 
 @since 1.1.0
 */
@protocol DVATableViewCellIdentifierProtocol <NSObject>
/**
 @author Pablo Romeu, 15-05-12 09:05:51
 
 Returns the identifier of the cell
 
 @return a cell identifier
 @warning this must never return nil
 @since 1.1.0
 */
-(NSString*)dva_identifierForCell;

@end