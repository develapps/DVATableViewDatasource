//
//  DVATableViewEditManager.h
//  TableViewTesting
//
//  Created by Pablo Romeu on 30/9/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewModelEditableDatasource.h"

/**
 @author Pablo Romeu, 15-10-15 12:10:13
 
 A manager to manage the animations of a Tableview using MVVM paradigm. It should be initialized with a TableView and a <DVATableViewModelEditableDatasource> compliant object:

    DVATableViewEditManager *manager = [[DVATableViewEditManager alloc] initWithTableView:self.TableView];
    id<DVATableViewModelEditableDatasource> editableDatasource = [[id<DVATableViewModelEditableDatasource> alloc]initWithAnimationEditor:manager];

 Updates will be performed immediatelly unless you embed them inside a block in dva_performUpdates:withCompletionBlock:
 @since 1.0
 */
@interface DVATableViewEditManager : NSObject

/*!
 @author Pablo Romeu, 15-10-15 12:10:40
 
 The viewModelDatasource. It will be set when the <DVATableViewModelEditableDatasource> compliant object is initialized with the manager at [DVATableViewModelEditableDatasource initWithAnimationEditor:]
 
 @since 1.0
 */
@property (nonatomic,weak)  id <DVATableViewModelEditableDatasource>    viewModelDataSource;

/*!
 @author Pablo Romeu, 15-10-15 12:10:59
 
 Initializer
 
 @param TableView the TableView to control
 
 @return a manager
 
 @since 1.0
 */
-(instancetype)initWithTableView:(UITableView*)TableView;

#pragma mark - cell editing

-(void)dva_animateInsertViewModel:(id)viewModel
                      atIndexPath:(NSIndexPath*)indexPath;
-(void)dva_animateReloadViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_animateDeleteViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_animateMoveViewModelAtIndexPath:(NSIndexPath*)indexPath
                               toIndexPath:(NSIndexPath *)newIndexPath;

#pragma mark - section editing

-(void)dva_animateInsertSectionViewModel:(id)viewModel
                             atIndexPath:(NSIndexPath*)indexPath;
-(void)dva_animateReloadSectionViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_animateDeleteSectionViewModelAtIndexPath:(NSIndexPath*)indexPath;
-(void)dva_animateMoveSectionViewModelAtIndexPath:(NSIndexPath*)indexPath
                                      toIndexPath:(NSIndexPath *)newIndexPath;

-(void)dva_performUpdates:(void (^)(void))updates withCompletionBlock:(void (^)(BOOL finished))completion;
-(void)dva_cancelPendingEditions;
@end


