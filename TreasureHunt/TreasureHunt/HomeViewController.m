//
//  HomeViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "CacheListViewController.h"
#import "NewCacheViewController.h"
#import "MapViewController.h"
#import "Cache.h"
#import "CodeDataHelper.h"

@interface HomeViewController ()
@property(nonatomic, strong) CodeDataHelper* cdHelper;
@end

@implementation HomeViewController{
    UIStoryboard *_storyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [[NSBundle mainBundle] bundleIdentifier]);
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)listCaches:(UIButton *)sender {
        CacheListViewController *cachesList = [_storyboard instantiateViewControllerWithIdentifier:@"cachesList"];
        PFQuery *query = [PFQuery queryWithClassName:@"Cash"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                cachesList.caches = objects;
                [self presentViewController:cachesList animated:YES completion:nil];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fetching data failed!" message:@"Check connection!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];

}

-(void)listFavourites:(UIButton *)sender{
            CacheListViewController *favourites = [_storyboard instantiateViewControllerWithIdentifier:@"favourites"];

    [self presentViewController:favourites animated:YES completion:nil];
}

- (IBAction)addCache:(UIButton *)sender {
    NewCacheViewController *newCacheView = [_storyboard instantiateViewControllerWithIdentifier:@"newCache"];
    [self presentViewController:newCacheView animated:YES completion:nil];
}

- (IBAction)loadMap:(UIButton *)sender {
    MapViewController *mapView = [_storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self presentViewController:mapView animated:YES completion:nil];

}
@end
