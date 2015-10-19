//
//  DVATableViewAnimationManager.m
//  TableViewTesting
//
//  Created by Pablo Romeu on 30/9/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewEditManager.h"
#import "DVATableViewUpdate.h"

@interface DVATableViewEditManager ()
@property (nonatomic,strong,readwrite)      NSMutableDictionary *cellUpdates,*sectionUpdates;
@property (nonatomic,strong)                NSMutableDictionary *insertedCellViewModels,*insertedSectionViewModels;

@property (nonatomic,weak)                  UITableView         *tableView;
@property (nonatomic)                       BOOL                isPerformingUpdates;

@end

@implementation DVATableViewEditManager

-(instancetype)initWithTableView:(UITableView *)tableView{
    self = [self init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellUpdates = [NSMutableDictionary new];
        self.sectionUpdates = [NSMutableDictionary new];
        self.insertedCellViewModels = [NSMutableDictionary new];
        self.insertedSectionViewModels = [NSMutableDictionary new];
    }
    return self;
}

- (NSComparisonResult)indexPathA:(NSIndexPath*)ip andB:(NSIndexPath*)ipB{
    if (ip.section>ipB.section) {
        return NSOrderedDescending;
    }
    else if (ip.section<ipB.section){
        return NSOrderedAscending;
    }
    else {
        if (ip.row>ipB.row) {
            return NSOrderedDescending;
        }
        else if (ip.row<ipB.row){
            return NSOrderedAscending;
        }
        else{
            return NSOrderedSame;
        }
    }
}

- (NSMutableArray*)cellUpdatesForType:(DVATableViewUpdateType)type{
    NSMutableArray *cells = [self.cellUpdates objectForKey:@(type)];
    if (!cells) {
        cells = [NSMutableArray new];
        [self.cellUpdates setObject:cells forKey:@(type)];
    }
    [cells sortUsingComparator:^NSComparisonResult(DVATableViewUpdate* obj1, DVATableViewUpdate* obj2) {
        if (type==DVATableViewUpdateTypeDelete) return [self indexPathA:obj2.dva_indexPath andB:obj1.dva_indexPath];
        return [self indexPathA:obj1.dva_indexPath andB:obj2.dva_indexPath];
    }];
    return cells;
}

- (NSMutableArray*)sectionUpdatesForType:(DVATableViewUpdateType)type{
    NSMutableArray *sections = [self.sectionUpdates objectForKey:@(type)];
    if (!sections) {
        sections = [NSMutableArray new];
        [self.sectionUpdates setObject:sections forKey:@(type)];
    }
    [sections sortUsingComparator:^NSComparisonResult(DVATableViewUpdate* obj1, DVATableViewUpdate* obj2) {
        if (type==DVATableViewUpdateTypeDelete) return [self indexPathA:obj2.dva_indexPath andB:obj1.dva_indexPath];
        return [self indexPathA:obj1.dva_indexPath andB:obj2.dva_indexPath];
    }];
    return sections;
}

#pragma mark - cell editing

-(void)dva_animateInsertViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath{
    @synchronized(self) {
        [self.insertedCellViewModels setObject:viewModel forKey:indexPath];
        [[self cellUpdatesForType:DVATableViewUpdateTypeInsert] addObject:[[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeInsert indexPath:indexPath otherIndexPath:nil]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
    
}
-(void)dva_animateReloadViewModelAtIndexPath:(NSIndexPath *)indexPath{
    @synchronized(self) {
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeUpdate ] addObject: [[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeUpdate indexPath:indexPath otherIndexPath:nil]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}
-(void)dva_animateDeleteViewModelAtIndexPath:(NSIndexPath *)indexPath{
    @synchronized(self) {
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeDelete ] addObject:[[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeDelete indexPath:indexPath otherIndexPath:nil]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}
-(void)dva_animateMoveViewModelAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath{
    @synchronized(self) {
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeMove] addObject:[[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeMove indexPath:indexPath otherIndexPath:newIndexPath]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}
#pragma mark - section editing

-(void)dva_animateInsertSectionViewModel:(id)viewModel
                             atIndexPath:(NSIndexPath *)indexPath{
    @synchronized(self) {
        [self.insertedSectionViewModels setObject:viewModel forKey:indexPath];
        [[self sectionUpdatesForType:DVATableViewUpdateTypeInsert] addObject:[[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeInsert indexPath:indexPath otherIndexPath:nil]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}
-(void)dva_animateReloadSectionViewModelAtIndexPath:(NSIndexPath *)indexPath{
    @synchronized(self) {
        
        [[self sectionUpdatesForType:DVATableViewUpdateTypeUpdate] addObject: [[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeUpdate indexPath:indexPath otherIndexPath:nil]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}
-(void)dva_animateDeleteSectionViewModelAtIndexPath:(NSIndexPath *)indexPath{
    @synchronized(self) {
        
        [[self sectionUpdatesForType:DVATableViewUpdateTypeDelete] addObject:[[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeDelete indexPath:indexPath otherIndexPath:nil]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}
-(void)dva_animateMoveSectionViewModelAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath{
    @synchronized(self) {
        [[self sectionUpdatesForType:DVATableViewUpdateTypeMove] addObject:[[DVATableViewUpdate alloc] initWithType:DVATableViewUpdateTypeMove indexPath:indexPath otherIndexPath:newIndexPath]];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

#pragma mark - perform updates

-(void)dva_performUpdates:(void (^)(void))updates withCompletionBlock:(void (^)(BOOL finished))completion{
    @synchronized(self) {
        
        [self.tableView beginUpdates];
        // At the synchronized part -INSIDE the begin/endUpdates- we should enable perform updates and perform the batch Updates.
        self.isPerformingUpdates = YES;
        if (updates) updates();
        [[self sectionUpdatesForType:DVATableViewUpdateTypeDelete] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([obj isKindOfClass:[DVATableViewUpdate class]], @"ERROR: %@ does not conform to DVATableViewUpdate",obj);
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_deleteSectionViewModelAtIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_deleteSectionViewModelAtIndexPath:)));
            
            [self.viewModelDataSource dva_deleteSectionViewModelAtIndexPath:obj.dva_indexPath];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:obj.dva_indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [[self sectionUpdatesForType:DVATableViewUpdateTypeInsert] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_insertSectionViewModel:atIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_insertSectionViewModel:atIndexPath:)));
            
            id <DVATableViewModelProtocol> vm=[self.insertedSectionViewModels objectForKey:obj.dva_indexPath];
            [self.viewModelDataSource dva_insertSectionViewModel:vm
                                                     atIndexPath:obj.dva_indexPath];
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:obj.dva_indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [[self sectionUpdatesForType:DVATableViewUpdateTypeMove] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_moveSectionViewModelAtIndexPath:toIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_moveSectionViewModelAtIndexPath:toIndexPath:)));
            
            [self.viewModelDataSource dva_moveSectionViewModelAtIndexPath:obj.dva_indexPath toIndexPath:obj.dva_toIndexPath];
            [self.tableView moveSection:obj.dva_indexPath.section toSection:obj.dva_toIndexPath.section];
        }];
        
        [[self sectionUpdatesForType:DVATableViewUpdateTypeUpdate] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_reloadSectionViewModelAtIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_reloadSectionViewModelAtIndexPath:)));
            [self.viewModelDataSource dva_reloadSectionViewModelAtIndexPath:obj.dva_indexPath];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:obj.dva_indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        
        // CELLS
        
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeDelete] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_deleteViewModelAtIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_deleteViewModelAtIndexPath:)));
            
            [self.viewModelDataSource dva_deleteViewModelAtIndexPath:obj.dva_indexPath];
            [self.tableView deleteRowsAtIndexPaths:@[[obj dva_indexPath]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeInsert] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_insertViewModel:atIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_insertViewModel:atIndexPath:)));
            id <DVATableViewModelProtocol> vm=[self.insertedCellViewModels objectForKey:obj.dva_indexPath];
            [self.viewModelDataSource dva_insertViewModel:vm atIndexPath:obj.dva_indexPath];
            [self.tableView insertRowsAtIndexPaths:@[[obj dva_indexPath]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeMove] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_moveViewModelAtIndexPath:toIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_moveViewModelAtIndexPath:toIndexPath:)));
            
            [self.viewModelDataSource dva_moveViewModelAtIndexPath:obj.dva_indexPath toIndexPath:obj.dva_toIndexPath];
            [self.tableView moveRowAtIndexPath:[obj dva_indexPath] toIndexPath:[obj dva_toIndexPath]];
        }];
        
        [[self cellUpdatesForType:DVATableViewUpdateTypeUpdate] enumerateObjectsUsingBlock:^(DVATableViewUpdate*obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([self.viewModelDataSource respondsToSelector:@selector(dva_reloadViewModelAtIndexPath:)], @"ERROR: %@ does not perform selector %@",self.viewModelDataSource,NSStringFromSelector(@selector(dva_reloadViewModelAtIndexPath:)));
            [self.viewModelDataSource dva_reloadViewModelAtIndexPath:obj.dva_indexPath];
            [self.tableView reloadRowsAtIndexPaths:@[[obj dva_indexPath]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [self dva_cancelPendingEditions];
        
#warning can this occur in a tableView?
        // Maybe some modifications occurred during our animation
        if ([self.cellUpdates count] > 0 ||
            [self.sectionUpdates count] >0) {
            [self dva_performUpdates:nil withCompletionBlock:nil];
        }
        else{
            self.isPerformingUpdates = NO;
        }
        if (completion) completion(YES);
        [self.tableView endUpdates];
    }
}

-(void)dva_cancelPendingEditions{
    [self.cellUpdates removeAllObjects];
    [self.sectionUpdates removeAllObjects];
    [self.insertedCellViewModels removeAllObjects];
    [self.insertedSectionViewModels removeAllObjects];
}
@end
