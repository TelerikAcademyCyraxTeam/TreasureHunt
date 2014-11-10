//
//  FavoritesCacheDetailsViewController.h
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cache.h"

@interface FavoritesCacheDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *cacheName;
@property (weak, nonatomic) IBOutlet UILabel *cacheIsFound;
@property (weak, nonatomic) IBOutlet UILabel *cacheCreatedBy;
@property (weak, nonatomic) IBOutlet UILabel *cacheDesciption;
@property (weak, nonatomic) IBOutlet UILabel *cacheHint;
- (IBAction)showMap:(id)sender;
- (IBAction)backButton:(id)sender;

@property(strong,nonatomic) Cache *currentCache;

@end
