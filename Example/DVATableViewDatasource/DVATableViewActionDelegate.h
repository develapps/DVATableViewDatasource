//
//  Header.h
//  DVATableViewDatasource
//
//  Created by Pablo Romeu on 13/5/15.
//  Copyright (c) 2015 Pablo Romeu. All rights reserved.
//

@protocol DVATableViewActionDelegate <NSObject>

-(void)cell:(UITableViewCell*)cell switchDidSwitch:(UISwitch*)aSwitch;

@end