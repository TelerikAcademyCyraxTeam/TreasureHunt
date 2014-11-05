//
//  LoginViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loginUserWithName:(NSString*) username
              andPassword:(NSString *)password{
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error){
        if(user){
            //push home view controller
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed!" message:@"Incorrect username or password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
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
