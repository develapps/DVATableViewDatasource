//
//  DVATableViewCell.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCell.h"
#import "DVATestCellModel.h"

@interface  DVATableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel    *theLabel;
@property (weak, nonatomic) IBOutlet UISwitch   *theSwitch;

-(IBAction)switched:(UISwitch*)sender;

@end

@implementation DVATableViewCell

-(void)bindWithModel:(id)viewModel{
    DVATestCellModel*model=viewModel;
    [self.theLabel setText:model.title];
    [self.theSwitch setOn:model.isOn];
}

-(IBAction)switched:(UISwitch*)sender{
    [self.delegate cell:self switchDidSwitch:sender];
}

@end
