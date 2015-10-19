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

#pragma mark - Protocol DVAViewModelDatasource

-(NSInteger)dva_numberOfSectionsInViewModel{
    return [self.viewModelArray count] > 0 ? 1 : 0;
}
-(NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    return [self.viewModelArray count];
}
- (id<DVATableViewModelProtocol>)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0        &&
        indexPath.row>=0             &&
        indexPath.row<[self.viewModelArray count]) {
        return [self.viewModelArray objectAtIndex:indexPath.row];
    }
    return nil;
}


#pragma mark - insertions

-(void)dva_insertViewModel:(id<DVATableViewModelProtocol>)viewModel
               atIndexPath:(NSIndexPath*)indexPath{
    [self.viewModelArray insertObject:viewModel atIndex:indexPath.row];
}
-(void)dva_reloadViewModelAtIndexPath:(NSIndexPath*)indexPath{
    // No action for this :)
}
-(void)dva_deleteViewModelAtIndexPath:(NSIndexPath*)indexPath{
    [self.viewModelArray removeObjectAtIndex:indexPath.row];
}
-(void)dva_moveViewModelAtIndexPath:(NSIndexPath*)indexPath
                        toIndexPath:(NSIndexPath *)newIndexPath{
    id <DVATableViewModelProtocol>vm = [self dva_viewModelForRowAtIndexPath:indexPath];
    [self.viewModelArray removeObjectAtIndex:indexPath.row];
    [self.viewModelArray insertObject:vm atIndex:newIndexPath.row];
}

#pragma mark - tapped

-(void)groupedAnimation{
    //    NSUInteger row = arc4random_uniform([self.cellViewModel count]);
    __block NSUInteger row = 0;
    
    __block NSIndexPath*ip = [NSIndexPath indexPathForItem:row inSection:0];
    __block CellEntityMapper *cellVM=[self.viewModelArray objectAtIndex:row];
        
    [self.manager dva_performUpdates:^{
        // Insert
        [self.manager dva_animateInsertViewModel:cellVM atIndexPath:ip];
        
        // Delete
        ip = [NSIndexPath indexPathForItem:row+2 inSection:0];
        [self.manager dva_animateDeleteViewModelAtIndexPath:ip];
        
        // Update
        ip = [NSIndexPath indexPathForItem:row+1 inSection:0];
        [self.manager  dva_animateReloadViewModelAtIndexPath:ip];
        
        ip = [NSIndexPath indexPathForItem:row inSection:0];
        NSIndexPath *ipOther = [NSIndexPath indexPathForItem:(row+6)%[self.viewModelArray count]
                                                   inSection:0];
        NSLog(@"moving %@ to %@",ip,ipOther);
        [self.manager dva_animateMoveViewModelAtIndexPath:ip toIndexPath:ipOther];
        
        
    } withCompletionBlock:^(BOOL finished) {
        NSLog(@"done block updates!");
    }];
}

-(void)nonGroupedAnimation{
    //    NSUInteger row = arc4random_uniform([self.cellViewModel count]);
    __block NSUInteger row = 0;
    
    __block NSIndexPath*ip = [NSIndexPath indexPathForItem:row inSection:0];
    __block CellEntityMapper *cellVM=[self.viewModelArray objectAtIndex:row];
    
    //    // Insert
    
    [self.manager dva_performUpdates:^{
        [self.manager dva_animateInsertViewModel:cellVM atIndexPath:ip];
    }
                 withCompletionBlock:^(BOOL finished) {
                     NSLog(@"done inserting!");
                 }];
    
    // Delete
    ip = [NSIndexPath indexPathForItem:row inSection:0];
    
    [self.manager dva_performUpdates:^{
        [self.manager dva_animateDeleteViewModelAtIndexPath:ip];
    }
                 withCompletionBlock:^(BOOL finished) {
                     NSLog(@"done deleting!");
                 }];
    
    
    // Update
    ip = [NSIndexPath indexPathForItem:row inSection:0];
    
    
    cellVM=[self.viewModelArray objectAtIndex:row];
    [self.manager dva_performUpdates:^{
        [self.manager  dva_animateReloadViewModelAtIndexPath:ip];
    }
                 withCompletionBlock:^(BOOL finished) {
                     NSLog(@"done reload!");
                 }];
    
    
    
    //         Move
    
    ip = [NSIndexPath indexPathForItem:row inSection:0];
    NSIndexPath *ipOther = [NSIndexPath indexPathForItem:(row+6)%[self.viewModelArray count]
                                               inSection:0];
    NSLog(@"moving %@ to %@",ip,ipOther);
    [self.manager dva_performUpdates:^{
        [self.manager dva_animateMoveViewModelAtIndexPath:ip toIndexPath:ipOther];
    }
                 withCompletionBlock:^(BOOL finished) {
                     NSLog(@"done moving!");
                 }];
    
    
}

-(void)tappedButton{
    if (_grouped) {
        [self groupedAnimation];
    }
    else{
        [self nonGroupedAnimation];
    }
    _grouped = !_grouped;
};


@end
