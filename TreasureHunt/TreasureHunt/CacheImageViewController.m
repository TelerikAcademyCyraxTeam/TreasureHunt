//
//  CacheImageViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "CacheImageViewController.h"

@interface CacheImageViewController ()

@end

@implementation CacheImageViewController{
    UISwipeGestureRecognizer * _swiperight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image.image = self.imageFile;
    _swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    _swiperight.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:_swiperight];
    // Do any additional setup after loading the view.
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
