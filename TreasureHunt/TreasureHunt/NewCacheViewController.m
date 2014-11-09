//
//  NewCacheViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "NewCacheViewController.h"
#import <Parse/Parse.h>
#import "Toast.h"

@interface NewCacheViewController (){
    
}

@end

@implementation NewCacheViewController{
    CLLocationManager *manager;
    CLLocation *currentLocation;
    UILongPressGestureRecognizer *_longPress;
    UIStoryboard *_storyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
       [self getLocation];
    _storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(loadNextView)];
    _longPress.minimumPressDuration = 1.0f;
    _longPress.allowableMovement = 100.0f;
    [self.view addGestureRecognizer:_longPress];
}

-(void)loadNextView{
    UIViewController *next = [_storyboard instantiateViewControllerWithIdentifier:@"longPressHome"];
    [self presentViewController:next animated:YES completion:nil];
    
}

-(void) getLocation{
    manager.delegate = self;
    manager.distanceFilter = 20;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to get location!" message:@"Locating not completed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    currentLocation = [locations lastObject];
    
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

- (IBAction)createCache:(UIButton *)sender {
    NSString *name = self.name.text;
    NSString *location = self.locatedIn.text;
    NSString *cacheDescription = self.cacheDescription.text;
    NSString *cacheHints = self.hints.text;
    PFObject *cache = [[PFObject alloc] initWithClassName:@"Cash"];
    PFUser *currentUser = [PFUser currentUser];
    cache[@"name"] = name;
    cache[@"Town"] = location;
    cache[@"cashDescription"] = cacheDescription;
    cache[@"hint"] = cacheHints;
    cache[@"isFound"] = [NSNumber numberWithBool:NO];
    cache[@"createdBy"] = currentUser.username;
    PFGeoPoint *cacheLocation = [PFGeoPoint geoPointWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    cache[@"location"] = cacheLocation;
    [cache saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            [self.view makeToast:@"Cache created!"];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create command failed!" message:@"check newCacheViewController" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];

    }
@end
