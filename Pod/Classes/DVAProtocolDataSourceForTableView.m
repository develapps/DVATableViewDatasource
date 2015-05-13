//
//  DVAProtocolDataSourceForTableView
//  Close2Me
//
//  Created by Rafa Barberá on 08/05/14.
//  Copyright (c) 2014 develapps. All rights reserved.
//

#import "DVAProtocolDataSourceForTableView.h"

@interface DVAProtocolDataSourceForTableView ()

#pragma mark - views
@property (strong,nonatomic)    NSMutableDictionary*titleHeadersPerSection,*titleFootersPerSection;
@property (nonatomic)           BOOL debug;

@end

@implementation DVAProtocolDataSourceForTableView

- (instancetype)init
{
    self = [super init];
    if (self) {        
        _titleFootersPerSection                 = [NSMutableDictionary new];
        _titleHeadersPerSection                 = [NSMutableDictionary new];
        _debug                                  = NO;
    }
    return self;
}


#pragma mark - datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModelDataSource dva_numberOfSectionsInViewModel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModelDataSource dva_numberOfViewModelsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id <DVATableViewModelProtocol> viewModel = [self.viewModelDataSource dva_viewModelForRowAtIndexPath:indexPath];
    
    NSAssert([viewModel respondsToSelector:@selector(dva_cellIdentifier)], @"ERROR %@: Trying to setup a cell with a model that does not conform DVATableViewModelProtocol at indexPath %@",[self class],indexPath);
    
    NSString*identifier=viewModel.dva_cellIdentifier;
    
    UITableViewCell <DVATableViewCellProtocol> *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSAssert([cell respondsToSelector:@selector(bindWithModel:)], @"ERROR %@: Trying to setup a cell that does not conform DVATableViewCellProtocol at indexPath %@",[self class],indexPath);
    
    [cell bindWithModel:viewModel];
    if (self.debug) NSLog(@"DEBUG %@: Returning configured cell %@ with viewModel %@ for indexpath (%@)",[self class],cell,viewModel,indexPath);

    return cell;
}

#pragma mark - Datasource headers and footers

-(void)setTitleFooter:(NSString*)footer ForSection:(NSInteger)section{
    
    NSAssert([footer length]>0, @"ERROR %@: No title passed at section %ld",[self class],(long)section);
    NSAssert(section>=0, @"ERROR %@: No valid section passed for footer. Section %li",[self class],(long)section);
    
    if (self.debug) NSLog(@"DEBUG %@: Setting up footer %@ for section %ld",[self class],footer,(long)section);

    [self.titleFootersPerSection setObject:footer forKey:@(section)];
}

-(void)setTitleHeader:(NSString*)header ForSection:(NSInteger)section{
    
    NSAssert([header length]>0, @"ERROR %@: No title passed at section %ld",[self class],(long)section);
    NSAssert(section>=0, @"ERROR %@: No valid section passed for footer. Section %li",[self class],(long)section);

    if (self.debug) NSLog(@"DEBUG %@: Setting up header %@ for section %ld",[self class],header,(long)section);
    
    [self.titleHeadersPerSection setObject:header forKey:@(section)];
}


-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    if (self.titleFootersPerSection[@(section)]) {
        if (self.debug) NSLog(@"DEBUG %@: Setting up footer %@ for section %ld",[self class],self.titleFootersPerSection[@(section)],(long)section);
        return self.titleFootersPerSection[@(section)];
    }
    return nil;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.titleHeadersPerSection[@(section)]) {
        if (self.debug) NSLog(@"DEBUG %@: Setting up header %@ for section %ld",[self class],self.titleHeadersPerSection[@(section)],(long)section);
        return self.titleHeadersPerSection[@(section)];
    }
    return nil;
}



@end
