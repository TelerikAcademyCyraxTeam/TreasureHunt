//
//  FavouritesViewController.h
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import <Parse/Parse.h>

@interface FavouritesViewController : UIViewController<SWTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *caches;
@end
