//
//  CacheDetailsViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/10/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "CacheDetailsViewController.h"
#import <Parse/Parse.h>

@interface CacheDetailsViewController ()

@end

@implementation CacheDetailsViewController{
    UIImage *image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBackground.png"]];
    self.name.text = [self.currentCache objectForKey:@"name"];
       BOOL flag = [self.currentCache objectForKey:@"isFound"];
    if(flag == YES){
        self.isFound.text = @"YES";
    }
    else{
        self.isFound.text = @"NO";
    }
    NSString *str =  [self.currentCache objectForKey:@"cashDescription"];
    self.cacheDescription.text =[self.currentCache objectForKey:@"cashDescription"];
    self.hint.text = [self.currentCache objectForKey:@"hint"];
    self.createdBy.text = [self.currentCache objectForKey:@"createdBy"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for(PFObject *file in objects){
                if([file objectForKey:@"imageName"] != [self.currentCache objectForKey:@"photo"]){
                    PFFile *data =[file objectForKey:@"imageFile"];
                   // image = [UIImage imageWithData:[file objectForKey:@"imageFile"]];
                    NSLog(@"%@",image);
                    break;
                }
            }
        }
        else{
            NSLog(@"MMMMMMMMMMMMMM");
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showImage:(UIButton *)sender {
}

- (IBAction)loadMap:(UIButton *)sender {
}
- (IBAction)getBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
