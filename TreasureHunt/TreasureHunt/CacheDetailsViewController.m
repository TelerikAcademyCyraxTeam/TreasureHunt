//
//  CacheDetailsViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "CacheDetailsViewController.h"
#import <Parse/Parse.h>
#import "CacheImageViewController.h"
#import "SingleCacheMapViewController.h"
#import "CacheListViewController.h"
@interface CacheDetailsViewController ()

@end

@implementation CacheDetailsViewController{
    UIImage *image;
    UIStoryboard *_storyboard;
    UISwipeGestureRecognizer *_swipeUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
    
    
        self.name.text = [self.currentCache objectForKey:@"name"];
        BOOL flag = [self.currentCache objectForKey:@"isFound"];
        NSLog(@"%d",(int)flag);
        if(flag == YES){
            self.isFound.text = @"YES";
        }
        else{
            self.isFound.text = @"NO";
        }
        
        self.cacheDescription.text =[self.currentCache objectForKey:@"cashDescription"];
        self.hint.text = [self.currentCache objectForKey:@"hint"];
        self.createdBy.text = [self.currentCache objectForKey:@"createdBy"];
     

    
    
      /* self.name.text = self.localCache.name;
        if(self.localCache.isFound){
            self.isFound.text = @"YES";
        }
        else{
            self.isFound.text = @"NO";
        }
        
        self.cacheDescription.text = self.localCache.cacheDescription;
        self.hint.text = self.localCache.hint;
        self.createdBy.text = self.localCache.userCreated;
      //  */
    
    _swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    _swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:_swipeUp];
    
        // Do any additional setup after loading the view.
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self getPhoto];
}

-(void) getPhoto{
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for(PFObject *file in objects){
                if([file objectForKey:@"imageName"] != [self.currentCache objectForKey:@"photo"]){
                    PFFile *data =[file objectForKey:@"imageFile"];
                    [data getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        if (!error) {
                            CacheImageViewController *cacheImageView = [_storyboard instantiateViewControllerWithIdentifier:@"image"];
                            image = [UIImage imageWithData:imageData];
                            cacheImageView.imageFile = image;
                            [self presentViewController:cacheImageView animated:YES completion:nil];
                            
                        }
                    }];
                    
                    break;
                }
            }
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showImage:(UIButton *)sender {
    [self getPhoto];
}

- (IBAction)loadMap:(UIButton *)sender {
    SingleCacheMapViewController *mapView = [[SingleCacheMapViewController alloc] init];
    [self presentViewController:mapView animated:YES completion:nil];
}
- (IBAction)getBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
