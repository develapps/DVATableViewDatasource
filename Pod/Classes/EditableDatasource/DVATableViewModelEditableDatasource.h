//
//  DVACollectionViewModelEditableDatasource.h
//
//  Created by Pablo Romeu on 1/10/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewModelDatasource.h"
@class DVATableViewEditManager;
@protocol DVATableViewModelEditableDatasource <DVATableViewModelDatasource>
/*!
 @author Pablo Romeu, 15-10-16 15:10:18
 
 You should at least setup yourself as animator manager's viewModelDatasource.
 
 @param manager the edit manager
 
 @since 1.0
 */
-(void)configureWithAnimatorManager:(DVATableViewEditManager*)manager;
@optional
-(void)dva_insertViewModel:(id)viewModel
               atIndexPath:(NSIndexPath*)indexPath;
-(void)dva_reloadViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_deleteViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_moveViewModelAtIndexPath:(NSIndexPath*)indexPath
                        toIndexPath:(NSIndexPath *)newIndexPath;

-(void)dva_insertSectionViewModel:(id)viewModel
                      atIndexPath:(NSIndexPath*)indexPath;
-(void)dva_reloadSectionViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_deleteSectionViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_moveSectionViewModelAtIndexPath:(NSIndexPath*)indexPath
                               toIndexPath:(NSIndexPath *)newIndexPath;
@end