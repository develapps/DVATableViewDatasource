//
//  DVATableDatasourceSectionMutableArray
//  Pods
//
//  Created by Pablo Romeu on 15/10/15.
//
//

#import "DVATableDatasourceSectionMutableArray.h"
#import "DVATableViewEditManager.h"

@interface DVATableDatasourceSectionMutableArray ()
@property (nonatomic,strong)    DVATableViewEditManager         *manager;
@property (nonatomic,strong)    NSMutableArray                  *array;
@property (nonatomic,strong)    NSMutableArray                  *addSectionArray,*removeIndexes,*removeSectionIndexes;
@property (nonatomic,strong)    NSMutableDictionary             *insertDict,*insertSectionDict,*addCellsDictionary;
@property (nonatomic)           BOOL                            isPerformingUpdates;

@end

@implementation  DVATableDatasourceSectionMutableArray

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
        
        self.array              = [NSMutableArray new];
        
        self.insertSectionDict  = [NSMutableDictionary new];
        self.insertDict         = [NSMutableDictionary new];
        
        self.addSectionArray    = [NSMutableArray new];
        self.addCellsDictionary = [NSMutableDictionary new];
        
        self.removeIndexes          = [NSMutableArray new];
        self.removeSectionIndexes   = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Protocol DVAViewModelDatasource

- (NSInteger)dva_numberOfSectionsInViewModel{
    return [self count];
}
-(NSInteger)dva_numberOfViewModelsInSection:(NSInteger)section{
    NSMutableArray *array = [self.array objectAtIndex:section];
    return [array count];
}
- (id<DVATableViewModelProtocol>)dva_viewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [self.array objectAtIndex:indexPath.section];
    return [array objectAtIndex:indexPath.row];
}


-(NSString *)description{
    return [self.array description];
}

#pragma mark - this should be overridden

- (NSUInteger)count{
    return [self.array count];
}

- (id)objectAtIndex:(NSUInteger)index{
    if ([self.array count]<=index) {
        return nil;
    }
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
        if (_debug) NSLog(@"ADDING OBJECT %@ self %zd addSectionArray %zd",anObject,[self count],[self.addSectionArray count]);
        NSAssert([anObject isKindOfClass:[NSMutableArray class]], @"ERROR: Section objects should be NSMutableArray classed");
        [self.addSectionArray addObject:anObject];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
    @synchronized(self) {
        if (_debug) NSLog(@"INSERTING at index %zd self %zd insertDict %zd",index,[self count],[self.insertSectionDict count]);
        NSAssert([anObject isKindOfClass:[NSMutableArray class]], @"ERROR: Section objects should be NSMutableArray classed");
        [self.insertSectionDict setObject:anObject forKey:@(index)];
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index{
    @synchronized(self) {
        [self.removeSectionIndexes addObject:@(index)];
        if (_debug) NSLog(@"REMOVING at index %zd self %zd remove %zd",index,[self count],[self.removeSectionIndexes count]);
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}



#pragma mark - Object

- (void)dva_addObject:(id)anObject atSection:(NSUInteger)section{
    @synchronized(self) {
        NSMutableArray*array = [self.addCellsDictionary objectForKey:@(section)];
        if (!array) {
            array = [NSMutableArray new];
            [self.addCellsDictionary setObject:array forKey:@(section)];
        }
        [array addObject:anObject];
        if (_debug) NSLog(@"ADDING %@ at section %zd self %zd array for section %zd",anObject,section,[self count],[array count]);
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

- (void)dva_insertObject:(id)anObject forKeyPath:(NSIndexPath*)indexPath{
    @synchronized(self) {
        [self.insertDict setObject:anObject forKey:indexPath];
        if (_debug) NSLog(@"INSERTING at indexPath %@ self %zd insertDict %zd",indexPath,[self count],[self.insertDict count]);
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }
}

- (void)dva_removeObjectAtIndexPath:(NSIndexPath*)indexPath{
    @synchronized(self) {
        [self.removeIndexes addObject:indexPath];
        if (_debug) NSLog(@"REMOVING at indexPath %@ self %zd remove %zd",indexPath,[self count],[self.removeIndexes count]);
        if (!self.isPerformingUpdates) [self dva_performUpdates:nil withCompletionBlock:nil];
    }

}

-(void)dva_performUpdates:(void (^)(void))updates withCompletionBlock:(void (^)(BOOL finished))completion{
    NSAssert(_manager, @"ERROR: A manager is needed.");
    [self.manager dva_performUpdates:^{
        @synchronized(self) {
            _isPerformingUpdates = YES;
            if (updates) updates();
            
            
            // SECTIONS
            
            //DELETIONS
            [self.removeSectionIndexes enumerateObjectsUsingBlock:^(NSNumber* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (_debug) NSLog(@"ANIMATING REMOVING SECTION %zd",[obj unsignedIntegerValue]);
                [self.manager dva_animateDeleteSectionViewModelAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[obj unsignedIntegerValue]]];
            }];
            
            // INSERTIONS
            
            for (NSNumber*index in [self.insertSectionDict allKeys]) {
                NSUInteger indexInt = [index unsignedIntegerValue];
                id object = [self.insertSectionDict objectForKey:index];
                if (_debug) NSLog(@"ANIMATING INSERTING SECTION index %zd",indexInt);
                [self.manager dva_animateInsertSectionViewModel:object atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexInt]];
            }
            
            // ADDS
            
            NSUInteger count = [self count] + [self.insertSectionDict count] - [self.removeSectionIndexes count];
            
            [self.addSectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (_debug) NSLog(@"ANIMATING ADDING SECTION %@ at index %zd",obj,count+idx);
                [self.manager dva_animateInsertSectionViewModel:obj atIndexPath:[NSIndexPath indexPathForItem:0 inSection:count+idx]];
            }];

            
            //CELLS
            
            //DELETIONS
            [self.removeIndexes enumerateObjectsUsingBlock:^(NSIndexPath* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (_debug) NSLog(@"ANIMATING REMOVING indexPath %@",obj);
                [self.manager dva_animateDeleteViewModelAtIndexPath:obj];
            }];
            
            // INSERTIONS
            
            for (NSIndexPath*indexPath in [self.insertDict allKeys]) {
                id object= [self.insertDict objectForKey:indexPath];
                if (_debug) NSLog(@"ANIMATING INSERTING %@ at index %@",object,indexPath);
                [self.manager dva_animateInsertViewModel:object atIndexPath:indexPath];
            }
            
            // ADDS
            
            for (NSNumber*sectionNumber in [self.addCellsDictionary allKeys]) {
                NSMutableArray *array = [self.addCellsDictionary objectForKey:sectionNumber];
                if ([self.array count]<=[sectionNumber unsignedIntegerValue]) {
                    [self.array insertObject:[NSMutableArray new] atIndex:[sectionNumber unsignedIntegerValue]];
                }
                NSMutableArray *current = [self.array objectAtIndex:[sectionNumber unsignedIntegerValue]];
                
                NSArray*inserted = [[self.insertDict allKeys] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSIndexPath* evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                    return evaluatedObject.section == [sectionNumber unsignedIntegerValue];
                }]];
                
                NSArray*removed = [self.removeIndexes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSIndexPath* evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                    return evaluatedObject.section == [sectionNumber unsignedIntegerValue];
                }]];
                
                NSUInteger count = [current count] + [inserted count] - [removed count];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSIndexPath *ip = [NSIndexPath indexPathForItem:count+idx inSection:[sectionNumber unsignedIntegerValue]];
                    if (_debug) NSLog(@"ANIMATING ADDING %@ at indexPath %@",obj,ip);
                    [self.manager dva_animateInsertViewModel:obj atIndexPath:ip];
                }];
            }
            
            
            [self.insertDict removeAllObjects];
            [self.insertSectionDict removeAllObjects];

            [self.removeIndexes removeAllObjects];
            [self.removeSectionIndexes removeAllObjects];
            
            [self.addCellsDictionary removeAllObjects];
            [self.addSectionArray removeAllObjects];
        };
        
    } withCompletionBlock:^(BOOL finished) {
        @synchronized(self) {
            if ([self.insertDict count] ||
                [self.insertSectionDict count] ||
                [self.removeIndexes count] ||
                [self.removeSectionIndexes count] ||
                [self.addSectionArray count] ||
                [self.addCellsDictionary count]) {
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

-(void)dva_insertSectionViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath{
    if (_debug) NSLog(@"MODEL INSERTING SECTION %@ at indexPath %@ previous count %zd",viewModel,indexPath,[self.array count]);
    NSAssert([self.array count]>=indexPath.section, @"ERROR: Cannot insert section %zd. Sections count %zd",indexPath.section, [self.array count]);
    [self.array insertObject:viewModel atIndex:indexPath.section];
}

-(void)dva_deleteSectionViewModelAtIndexPath:(NSIndexPath *)indexPath{
    if (_debug) NSLog(@"MODEL DELETING SECTION at indexPath %@ previous count %zd",indexPath,[self.array count]);
    NSAssert([self.array count]>=indexPath.section, @"ERROR: Cannot delete invalid section %zd. Sections count %zd",indexPath.section, [self.array count]);
    [self.array removeObjectAtIndex:indexPath.section];
}


-(void)dva_insertViewModel:(id)viewModel atIndexPath:(NSIndexPath *)indexPath{
    NSAssert([self.array count]>=indexPath.section, @"ERROR: Cannot insert row on section %zd. Sections count %zd",indexPath.section, [self.array count]);
    NSMutableArray *array = [self.array objectAtIndex:indexPath.section];
    if (_debug) NSLog(@"MODEL ADDING ROW %@ at indexPath %@, previous count %zd",viewModel,indexPath, [array count]);
    NSAssert([array count]>=indexPath.row, @"ERROR: Cannot insert row %zd on section %zd. Previous row count %zd",indexPath.row, indexPath.section, [array count]);
    [array insertObject:viewModel atIndex:indexPath.row];
}

-(void)dva_deleteViewModelAtIndexPath:(NSIndexPath *)indexPath{
    NSAssert([self.array count]>=indexPath.section, @"ERROR: Cannot remove row on section %zd. Sections count %zd",indexPath.section, [self.array count]);
    NSMutableArray *array = [self.array objectAtIndex:indexPath.section];
    if (_debug) NSLog(@"MODEL REMOVING ROW at indexPath %@, previous count %zd",indexPath, [array count]);
    [array removeObjectAtIndex:indexPath.row];
}

@end

