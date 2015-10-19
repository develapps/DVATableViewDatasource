//
//  DVATableViewCustomEditableDataSource.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 19/10/15.
//  Copyright © 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCustomEditableDataSource.h"
#import "CellEntityMapper.h"

@interface DVATableViewCustomEditableDataSource ()
@property (nonatomic,readwrite,strong)  NSMutableArray                  *viewModelArray;
@property (nonatomic,strong)            DVATableViewEditManager         *manager;
@property (nonatomic)                   BOOL                            grouped;
@end

@implementation DVATableViewCustomEditableDataSource

-(instancetype)initWithAnimationEditor:(DVATableViewEditManager*)manager{
    self = [self init];
    if (self) {
        [self configureWithAnimatorManager:manager];
    }
    return self;
}
-(void)configureWithAnimatorManager:(DVATableViewEditManager *)manager{
    manager.viewModelDataSource = self;
    self.manager = manager;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModelArray =[NSMutableArray new];
    }
    return self;
}

-(NSMutableArray*)viewModelsAtSection:(NSUInteger)section{
    return [self.viewModelArray objectAtIndex:section];
}


#pragma mark - Protocol DVAViewModelDatasource


-(NSInteger)dva_numberOfSectionsInViewModel{
    return [self.viewModelArray count];
}
-(NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    if ([self.viewModelArray count]<=section ||
        ![[self.viewModelArray objectAtIndex:section] isKindOfClass:[NSArray class]] ||
        [[self.viewModelArray objectAtIndex:section] count]==0) {
        return 0;
    }
    return [[self viewModelsAtSection:section] count];
}
- (id<DVATableViewModelProtocol>)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.viewModelArray count]<=indexPath.section ||
        ![[self.viewModelArray objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]] ||
        [[self.viewModelArray objectAtIndex:indexPath.section] count]==0) {
        return nil;
    }

    return [[self viewModelsAtSection:indexPath.section] objectAtIndex:indexPath.row];
}


#pragma mark - modifications

-(void)dva_insertSectionViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath{
    [self.viewModelArray insertObject:viewModel atIndex:indexPath.section];
}


-(void)dva_deleteSectionViewModelAtIndexPath:(NSIndexPath *)indexPath{
    [self.viewModelArray removeObjectAtIndex:indexPath.section];
}

-(void)dva_insertViewModel:(id<DVATableViewModelProtocol>)viewModel
               atIndexPath:(NSIndexPath*)indexPath{
    if ([self.viewModelArray count]<=indexPath.section) {
        [self.viewModelArray addObject:[NSMutableArray new]];
    }
    [[self viewModelsAtSection:indexPath.section] insertObject:viewModel atIndex:indexPath.row];
}
-(void)dva_reloadViewModelAtIndexPath:(NSIndexPath*)indexPath{
    // No action for this :)
}
-(void)dva_deleteViewModelAtIndexPath:(NSIndexPath*)indexPath{
    [[self viewModelsAtSection:indexPath.section] removeObjectAtIndex:indexPath.row];
}
-(void)dva_moveViewModelAtIndexPath:(NSIndexPath*)indexPath
                        toIndexPath:(NSIndexPath *)newIndexPath{
    id <DVATableViewModelProtocol>vm = [self dva_viewModelForRowAtIndexPath:indexPath];
    [[self viewModelsAtSection:indexPath.section] removeObjectAtIndex:indexPath.row];
    [[self viewModelsAtSection:indexPath.section] insertObject:vm atIndex:newIndexPath.row];
}

#pragma mark - tapped


-(void)tappedButton{
    
    //    NSUInteger row = arc4random_uniform([self.cellViewModel count]);
    __block NSUInteger row = 0;
    
    __block NSIndexPath*ip = [NSIndexPath indexPathForItem:row inSection:0];
    __block CellEntityMapper *cellVM=[[CellEntityMapper alloc] init];
    void (^updates)(void) = ^void(void) {
        
            [self.manager dva_animateDeleteSectionViewModelAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
            cellVM.title = @"Modified view model";
            NSMutableArray *array = [NSMutableArray arrayWithObject:cellVM];
            [self.manager dva_animateInsertSectionViewModel:array atIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
            
            // Insert
            cellVM.title = @"INSERTED CELL";
            [self.manager dva_animateInsertViewModel:cellVM atIndexPath:ip];
            
            // Delete
            ip = [NSIndexPath indexPathForItem:row+2 inSection:0];
            [self.manager dva_animateDeleteViewModelAtIndexPath:ip];
            
            // Update
            cellVM.title = @"UPDATED CELL";
            ip = [NSIndexPath indexPathForItem:row+1 inSection:0];
            [self.manager  dva_animateReloadViewModelAtIndexPath:ip];
            
            ip = [NSIndexPath indexPathForItem:row inSection:0];
            NSIndexPath *ipOther = [NSIndexPath indexPathForItem:(row+3)%[self.viewModelArray count]
                                                       inSection:0];
        
            NSLog(@"moving %@ to %@",ip,ipOther);
            [self.manager dva_animateMoveViewModelAtIndexPath:ip toIndexPath:ipOther];
            
            
       
    };
    
    
    if (_grouped) {
        [self.manager dva_performUpdates:^{
            updates();
        } withCompletionBlock:^(BOOL finished) {
            NSLog(@"done block updates!");
        }];
    }
    else{
        updates();
    }
    _grouped = !_grouped;
};


@end
