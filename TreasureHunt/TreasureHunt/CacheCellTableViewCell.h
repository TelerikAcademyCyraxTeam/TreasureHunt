//
//  CacheCellTableViewCell.h
//  TreasureHunt
//
//  Created by Admin on 11/7/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface CacheCellTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *town;
@property (weak, nonatomic) IBOutlet UILabel *date;


@end
