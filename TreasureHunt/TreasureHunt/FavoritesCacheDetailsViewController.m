//
//  FavoritesCacheDetailsViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "FavoritesCacheDetailsViewController.h"
#include "SingleCacheMapViewController.h"

@interface FavoritesCacheDetailsViewController ()

@end

@implementation FavoritesCacheDetailsViewController{
    UIStoryboard *_storyboard;
    UISwipeGestureRecognizer *_swipeUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
    
    self.cacheName.text = self.currentCache.name;
    if(self.currentCache.isFound){
        self.cacheIsFound.text = @"YES";
    }
    else{
        self.cacheIsFound.text = @"NO";
    }
    
    self.cacheDesciption.text = self.currentCache.cacheDescription;
    self.cacheHint.text = self.currentCache.hint;
    self.cacheCreatedBy.text = self.currentCache.userCreated;
    
    //_swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    //_swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    //[self.view addGestureRecognizer:_swipeUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMap:(UIButton *)sender {
    SingleCacheMapViewController *mapView = [[SingleCacheMapViewController alloc] init];
    [self presentViewController:mapView animated:YES completion:nil];
}
- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
