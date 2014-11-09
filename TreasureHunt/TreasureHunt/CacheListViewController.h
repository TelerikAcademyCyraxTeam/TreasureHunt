//
//  CacheListViewController.h
//  TreasureHunt
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface CacheListViewController : UIViewController<SWTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong) NSArray *caches;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
