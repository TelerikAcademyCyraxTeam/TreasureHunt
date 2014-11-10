//
//  LongPressHomeViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/9/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "LongPressHomeViewController.h"
#import <Parse/Parse.h>
#import "Toast.h"
#import "NewCacheViewController.h"
#import "MapViewController.h"
#import "CacheListViewController.h"
#import "Cache.h"
#import "CodeDataHelper.h"

@interface LongPressHomeViewController ()
@property(nonatomic, strong) CodeDataHelper* cdHelper;
@end

@implementation LongPressHomeViewController{
    UIStoryboard *_storyboard;
    UILongPressGestureRecognizer *_longPress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(returnToPreviousView)];
    _longPress.minimumPressDuration = 0.5f;
    _longPress.allowableMovement = 100.0f;
    [self.view addGestureRecognizer:_longPress];
}


-(void) returnToPreviousView{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)addCache:(UIButton *)sender {
    NewCacheViewController *newCacheView = [_storyboard instantiateViewControllerWithIdentifier:@"newCache"];
    [self presentViewController:newCacheView animated:YES completion:nil];
}

-(void)listFavourites:(UIButton *)sender{
    CacheListViewController *favourites = [_storyboard instantiateViewControllerWithIdentifier:@"favourites"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cache"];
    _cdHelper = [CodeDataHelper getInstance];
    [_cdHelper setupCoreData];
    NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
    favourites.caches = fetchedObjects;
    [self presentViewController:favourites animated:YES completion:nil];
}

- (IBAction)loadMap:(UIButton *)sender {
    MapViewController *newCacheView = [_storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self presentViewController:newCacheView animated:YES completion:nil];
}

@end
