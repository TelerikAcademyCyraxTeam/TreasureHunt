//
//  SingleCacheMapViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/9/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "SingleCacheMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Cache.h"
#import "CodeDataHelper.h"
#import "CacheListViewController.h"

@interface SingleCacheMapViewController ()

@end

@implementation SingleCacheMapViewController{
    CLLocationManager *manager;
    CLLocation *_currentLocation;
    GMSMapView *mapView_;
    GMSCameraPosition *camera;
    BOOL _isMapShowed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
    [self getLocation];
    _isMapShowed = NO;
}


-(void) getLocation {
    manager.delegate = self;
    manager.distanceFilter = 20;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _currentLocation = [locations lastObject];
    if(!_isMapShowed){
        [self createMap];
        [self setMarker];
        _isMapShowed = YES;
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to get location!" message:@"Locating not completed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    NSLog(@"Error: %@", error);
    [alert show];
}

-(IBAction) unwindToAddingCache:(UIStoryboardSegue *) unwindSegue{
    
}

-(void)createMap{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    camera = [GMSCameraPosition cameraWithLatitude:_currentLocation.coordinate.latitude
                                         longitude:_currentLocation.coordinate.longitude
                                              zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 50, 100, 20);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [button setTitle:@"<Back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeMap)  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.title = @"You are here!";
    marker.map = mapView_;
    
}
-(void)setMarker {
    
    PFObject * selectedCache = [CacheListViewController getSelectedCache];
    PFGeoPoint *currentCacheLocation = [selectedCache objectForKey:@"location"];
    GMSMarker *cacheMarker = [[GMSMarker alloc] init];
    
        // Creates a marker for the selected cache.
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(currentCacheLocation.latitude, currentCacheLocation.longitude);
    cacheMarker.position = coords;
    cacheMarker.title = [selectedCache objectForKey:@"name"];
    cacheMarker.snippet = [NSString stringWithFormat:@"By %@", [selectedCache objectForKey:@"createdBy"]];
    cacheMarker.appearAnimation = kGMSMarkerAnimationPop;
    cacheMarker.icon = [UIImage imageNamed:@"arrow.png"];
    cacheMarker.map = mapView_;
    
}

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
}

-(void) closeMap{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
