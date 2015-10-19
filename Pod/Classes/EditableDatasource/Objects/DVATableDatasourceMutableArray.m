//
//  DVATableDatasourceMutableArray
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import "DVATableDatasourceMutableArray.h"
#import "DVATableViewEditManager.h"

@interface DVATableDatasourceMutableArray ()
@property (nonatomic,strong)    DVATableViewEditManager     *manager;
@property (nonatomic,strong)    NSMutableArray              *array,*addArray,*removeIndexes;
@property (nonatomic,strong)    NSMutableDictionary         *insertDict;
@property (nonatomic)           BOOL                        isPerformingUpdates;
@end

@implementation  DVATableDatasourceMutableArray

-(instancetype)initWithTableView:(UITableView *)tableView{
    return [self initWithAnimationEditor:[[DVATableViewEditManager alloc] initWithTableView:tableView]];
}

-(instancetype)initWithAnimationEditor:(DVATableViewEditManager *)manager{
    self = [self init];
    if (self) {
        [self configureWithAnimatorManager:manager];
        self.isPerformingUpdates = NO;
    }
    return self;
}

-(void)configureWithAnimatorManager:(DVATableViewEditManager *)manager{
    self.manager = manager;
    self.manager.viewModelDataSource = self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = [NSMutableArray new];
        self.insertDict = [NSMutableDictionary new];
        self.addArray   = [NSMutableArray new];
        self.removeIndexes = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)dva_numberOfSectionsInViewModel{
    return 1;
}
-(NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    return [self count];
}
- (id<DVATableViewModelProtocol>)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0        &&
        indexPath.row>=0             &&
        indexPath.row<[self count]) {
        return [self objectAtIndex:indexPath.row];
    }
    return nil;
}

#pragma mark - this should be subclassed

-(NSString *)description{
    return [self.array description];
}

- (NSUInteger)count{
    return [self.array count];
}

- (id)objectAtIndex:(NSUInteger)index{
    return [self.array objectAtIndex:index];
}


- (void)removeLastObject{
    @synchronized(self) {
        NSUInteger count = [self count];
        [self removeObjectAtIndex:count-1];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    @synchronized(self) {
        [self removeObjectAtIndex:index];
        [self insertObject:anObject atIndex:index];
    }
}

#pragma mark - interesting methods


- (void)addObject:(id)anObject{
    @synchronized(self) {
        if (_debug) NSLog(@"ADDING OBJECT %@ self %zd insertDict %zd",anObject,[self count],[self.insertDict count]);
        [self.addArray addObject:anObject];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
    @synchronized(self) {
        [self.insertDict setObject:anObject forKey:@(index)];
        if (_debug) NSLog(@"INSERTING at index %zd self %zd insertDict %zd",index,[self count],[self.insertDict count]);
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index{
    @synchronized(self) {
        [self.removeIndexes addObject:@(index)];
        if (_debug) NSLog(@"REMOVING at index %zd self %zd remove %zd",index,[self count],[self.removeIndexes count]);
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

-(void)dva_performUpdates:(void (^)(void))updates withCompletionBlock:(void (^)(BOOL finished))completion{
    NSAssert(_manager, @"ERROR: A manager is needed.");
    [self.manager dva_performUpdates:^{
        @synchronized(self) {
            _isPerformingUpdates = YES;
            if (updates) updates();
            //DELETIONS
            [self.removeIndexes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                 if (_debug) NSLog(@"ANIMATING REMOVING index %zd",idx);
                                                      [self.manager dva_animateDeleteViewModelAtIndexPath:[NSIndexPath indexPathForItem:[obj unsignedIntegerValue] inSection:0]];
                                                  }];
            
            // INSERTIONS
            
            for (NSNumber*index in [self.insertDict allKeys]) {
                NSUInteger indexInt = [index unsignedIntegerValue];
                id object = [self.insertDict objectForKey:index];
                if (_debug) NSLog(@"ANIMATING INSERTING index %zd",indexInt);
                [self.manager dva_animateInsertViewModel:object atIndexPath:[NSIndexPath indexPathForItem:indexInt inSection:0]];
            }
            
            // ADDS
            
            NSUInteger count = [self count] + [self.insertDict count] - [self.removeIndexes count];
            
            [self.addArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (_debug) NSLog(@"ANIMATING ADDING %@ at index %zd",obj,count+idx);
                [self.manager dva_animateInsertViewModel:obj atIndexPath:[NSIndexPath indexPathForItem:count+idx inSection:0]];
            }];

            [self.insertDict removeAllObjects];
            [self.removeIndexes removeAllObjects];
            [self.addArray removeAllObjects];
        };
        
    } withCompletionBlock:^(BOOL finished) {
        @synchronized(self) {
            if ([self.insertDict count] ||
                [self.removeIndexes count] ||
                [self.addArray count]) {
                [self dva_performUpdates:nil withCompletionBlock:nil];
            }
            
            else{
                _isPerformingUpdates = NO;
            }
            if (completion) completion(finished);
        }
    }];
}

#pragma mark - datasource

-(void)dva_insertViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath{
    if (_debug) NSLog(@"MODEL ADDING %@ at index %zd count %zd",viewModel,indexPath.row,[self.array count]);
    [self.array insertObject:viewModel atIndex:indexPath.row];
}

-(void)dva_deleteViewModelAtIndexPath:(NSIndexPath *)indexPath{
    if (_debug) NSLog(@"MODEL REMOVING at index %zd count %zd",indexPath.row,[self.array count]);
    [self.array removeObjectAtIndex:indexPath.row];
}

@end
