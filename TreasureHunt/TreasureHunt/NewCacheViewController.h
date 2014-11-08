//
//  NewCacheViewController.h
//  TreasureHunt
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NewCacheViewController : UIViewController<CLLocationManagerDelegate>
- (IBAction)createCache:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *hints;
@property (weak, nonatomic) IBOutlet UITextView *cacheDescription;
@property (weak, nonatomic) IBOutlet UITextField *cacheLocation;
@property (weak, nonatomic) IBOutlet UITextField *cacheName;

@end
