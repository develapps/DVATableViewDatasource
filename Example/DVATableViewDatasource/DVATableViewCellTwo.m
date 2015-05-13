//
//  DVATableViewCellTwo.m
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 12/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

#import "DVATableViewCellTwo.h"
#import "DVATestCellModel.h"

@interface DVATableViewCellTwo () <DVATableViewCellProtocol>
@property (weak, nonatomic) IBOutlet UILabel *theLabel;
-(IBAction)switched:(UISwitch*)sender;

@end

@implementation DVATableViewCellTwo

-(void)bindWithModel:(id)viewModel{
    DVATestCellModel*model=viewModel;
    [self.theLabel setText:model.title];
    [self.contentView setBackgroundColor:[UIColor blueColor]];
}

-(IBAction)switched:(UISwitch*)sender{
    [self.delegate switchDidSwitch:sender];
}

@end