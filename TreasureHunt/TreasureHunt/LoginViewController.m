//
//  LoginViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Toast.h"
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
    //UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    //[self.view addSubview:backgroundView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
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
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HomeViewController *homeController = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"cachesList"];
            [self presentViewController:homeController animated:YES completion:nil];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed!" message:@"Check the correctness of your username and password and make sure you have Internet access!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

-(BOOL) validate:(NSString*) input{
    NSString *trimmed = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(!(trimmed == nil)){
        return YES;
    }
    return NO;
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
