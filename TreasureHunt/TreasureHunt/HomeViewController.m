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

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CacheListViewController *cachesList = [storyboard instantiateViewControllerWithIdentifier:@"cachesList"];
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

- (IBAction)addCache:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewCacheViewController *newCacheView = [storyboard instantiateViewControllerWithIdentifier:@"newCache"];
    [self presentViewController:newCacheView animated:YES completion:nil];
}
@end
