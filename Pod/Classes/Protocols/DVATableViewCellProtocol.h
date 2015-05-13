//
//  DVATableViewCellProtocol
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import <UIKit/UIKit.h>
@protocol DVATableViewModelProtocol;
/**
 @author Pablo Romeu, 15-05-12 16:05:25
 
 This protocol defines a configurable cell with a viewModel
 
 @since 1.1.0
 */
@protocol DVATableViewCellProtocol <NSObject>

/**
 @author Pablo Romeu, 15-05-12 16:05:54
 
 Implement ´bindWithModel:´ to map viewModel values to cell objects.
 
 @param viewModel the viewModel to configure the cell
 
 @since 1.1.0
 */
-(void)bindWithModel:(id<DVATableViewModelProtocol>)viewModel;

@end
