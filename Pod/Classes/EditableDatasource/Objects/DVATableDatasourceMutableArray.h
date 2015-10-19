//
//  DVATableDatasourceMutableArray
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import <Foundation/Foundation.h>
#import "DVATableViewModelEditableDatasource.h"
@class DVATableViewEditManager;

/*!
 @author Pablo Romeu, 15-10-15 12:10:42
 
 Helper to use NSMutableArray as DVATableViewModelEditableDatasource
 
 @since 1.0
 */
@interface DVATableDatasourceMutableArray : NSMutableArray <DVATableViewModelEditableDatasource>
/*!
 @author Pablo Romeu, 15-10-15 12:10:01
 
 Debugging property
 
 @since 1.0
 */
@property (nonatomic)   BOOL debug;
/*!
 @author Pablo Romeu, 15-10-15 12:10:45
 
 Pass the tableview that will be responsible of the management
 
 @param TableView the Table view
 
 @return an instance of the object
 
 @since 1.0
 */
-(instancetype)initWithTableView:(UITableView*)tableView;

/*!
 @author Pablo Romeu, 15-10-15 12:10:02
 
 Join animations in one block
 
 @param updates    the updates
 @param completion a completion block
 @warning  If several animations should be done toghether you *should* join then in an animation block

 @since 1.0
 */
-(void)dva_performUpdates:(void (^)(void))updates
      withCompletionBlock:(void (^)(BOOL finished))completion;
@end
