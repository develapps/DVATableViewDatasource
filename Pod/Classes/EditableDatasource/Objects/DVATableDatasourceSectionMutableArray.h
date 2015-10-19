//
//  DVATableDatasourceSectionMutableArray
//  Pods
//
//  Created by Pablo Romeu on 15/10/15.
//
//

#import <Foundation/Foundation.h>

#import "DVATableViewModelEditableDatasource.h"

/*!
 @author Pablo Romeu, 15-10-15 12:10:42
 
 Helper to use NSMutableArray as DVATableViewModelEditableDatasource with sections and cells. Each object should be a NSMutableArray
 
 @since 1.0
 */
@interface DVATableDatasourceSectionMutableArray : NSMutableArray <DVATableViewModelEditableDatasource>
/*!
 @author Pablo Romeu, 15-10-15 12:10:01
 
 Debugging property
 
 @since 1.0
 */
@property (nonatomic)   BOOL debug;

/*!
 @author Pablo Romeu, 15-10-15 12:10:45
 
 Pass the Table view that will be responsible of the management
 
 @param TableView the Table view
 
 @return an instance of the object
 
 @since 1.0
 */
-(instancetype)initWithTableView:(UITableView*)tableView;


#pragma mark - object modifications

/*!
 @author Pablo Romeu, 15-10-16 09:10:00
 
 Ads an object to an specified section

 If the section does not exist it is created
 
 @param anObject the object
 @param section  the section

 @since 1.0
 */
- (void)dva_addObject:(id)anObject atSection:(NSUInteger)section;
/*!
 @author Pablo Romeu, 15-10-16 09:10:53
 
 Inserts an object to an specified indexPath
 
 @param anObject  the object
 @param indexPath the indexPath to insert to
 
 @since 1.0
 */
- (void)dva_insertObject:(id)anObject forKeyPath:(NSIndexPath*)indexPath;

/*!
 @author Pablo Romeu, 15-10-16 09:10:34
 
 removes an object from an indexPath
 
 @param indexPath the indexPath
 
 @since 1.0
 */
- (void)dva_removeObjectAtIndexPath:(NSIndexPath*)indexPath;


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
