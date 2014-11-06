//
//  RegisterViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Toast.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registerUserWithName:(NSString *) name
                 andPassword:(NSString *) password
                    andemail:(NSString *) email{
 
    PFUser *user = [[PFUser alloc] init];
    user.username = name;
    user.password = password;
    user.email = email;

    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if(!error){
            [self.view makeToast:@"Successful registration!"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginView = [storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self presentViewController:loginView animated:YES completion:nil];
        }
        else{
            NSString *errorMessage  = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration failed!" message:errorMessage  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

-(BOOL) validatePassword:(NSString*)password
 andConfirmationPassword:(NSString*)confirm{
    if([password isEqualToString:confirm]){
        return YES;
    }
    return NO;
}

-(BOOL) validateUserName:(NSString *) username{
    NSString *trimmed = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(![trimmed  isEqualToString:@""]){
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

- (IBAction)registerUser:(UIButton *)sender {
    NSString *currentUserName = self.username.text;
    NSString *currentEmail = self.email.text;
    NSString *currentPassword = self.password.text;
    NSString *currentConfirmation = self.confirmedPassword.text;
    
    BOOL arePasswordsValid = [self validatePassword:currentPassword andConfirmationPassword:currentConfirmation];
    BOOL isUsernameValid = [self validateUserName:currentUserName];
    
    if(!arePasswordsValid){
        [self.view makeToast:@"Passwords don't match"];
    }
    
    if(!isUsernameValid){
        [self.view makeToast:@"Username cannot be empty!"];
    }
    
    if(arePasswordsValid && isUsernameValid){
        [self registerUserWithName:currentUserName andPassword:currentPassword andemail:currentEmail];
    }

}
@end
