//
//  LoginViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"

@interface LoginViewController () <PFLogInViewControllerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //PFLogInViewController *login = [[PFLogInViewController alloc] init];
    //login.delegate = self;
    //[self presentViewController:login animated:YES completion:nil];
    
    // Do any additional setup after loading the view.
}

-(void)login:(UIButton *)sender{
    NSString *username = self.username.text;
    NSString *pass = self.password.text;
    [self loginUserWithName:username andPassword:pass];
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
            HomeViewController *homeController = [[HomeViewController alloc] init];
            [self presentViewController:homeController animated:YES completion:nil];
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
