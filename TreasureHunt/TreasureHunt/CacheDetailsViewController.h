//
//  CacheDetailsViewController.h
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CacheDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *isFound;
@property (weak, nonatomic) IBOutlet UILabel *createdBy;
@property (weak, nonatomic) IBOutlet UILabel *cacheDescription;
@property (weak, nonatomic) IBOutlet UILabel *hint;
@property(strong,nonatomic) PFObject *currentCache;
- (IBAction)showImage:(UIButton *)sender;
- (IBAction)loadMap:(UIButton *)sender;
- (IBAction)getBack:(UIButton *)sender;

@end
