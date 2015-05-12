//
//  DVATableViewConfigurableCellProtocol.h
//  Pods
//
//  Created by Pablo Romeu on 12/5/15.
//
//

#import <UIKit/UIKit.h>
/**
 @author Pablo Romeu, 15-05-12 16:05:25
 
 This protocol defines a configurable cell with a viewModel
 
 @since 1.1.0
 */
@protocol DVATableViewConfigurableCellProtocol <NSObject>

/**
 @author Pablo Romeu, 15-05-12 16:05:54
 
 The viewModel to be set. 
 
 Implement ´setViewModel:´ to map viewModel values to cell objects.
 
 @since 1.1.0
 */
@property (nonatomic,strong) id viewModel;

@end