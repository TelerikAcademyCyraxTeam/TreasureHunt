//
//  MapViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Cache.h"
#import "CodeDataHelper.h"

@interface MapViewController () <GMSMapViewDelegate>
@property(nonatomic, strong) CodeDataHelper* cdHelper;
@end

@implementation MapViewController{
    CLLocationManager *manager;
    CLLocation *_currentLocation;
    GMSMapView *mapView_;
    GMSCameraPosition *camera;
    BOOL _isMapShowed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [[CLLocationManager alloc] init];
    [manager requestWhenInUseAuthorization];
    [self getLocation];
    _isMapShowed = NO;
    //[super viewDidLoad];
    //GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868 longitude:151.2086 zoom:6];
    //self.view = [GMSMapView mapWithFrame:CGRectZero camera:camera];
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
        [self setMarkers];
        _isMapShowed = YES;
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to get location!" message:@"Locating not completed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    NSLog(@"Error: %@", error);
    [alert show];
}

-(void)createMap{
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    camera = [GMSCameraPosition cameraWithLatitude:_currentLocation.coordinate.latitude
                                         longitude:_currentLocation.coordinate.longitude
                                              zoom:10];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;//  CLLocationCoordinate2DMake(42.7, 23.3333);
    marker.title = @"You are here!";
    //marker.snippet = @"Australia";
    marker.map = mapView_;
    
}
-(void)setMarkers {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cache"];
    //NSSortDescriptor *sort =
    //[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    //[request setSortDescriptors:[NSArray arrayWithObject:sort]];
    _cdHelper = [CodeDataHelper getInstance];
    [_cdHelper setupCoreData];
    NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
    
    
    for (Cache *cache in fetchedObjects) {
        // Creates a marker for every cache.
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake([cache.latitude doubleValue], [cache.longitude doubleValue]);
        GMSMarker *cacheMarker = [[GMSMarker alloc] init];
        cacheMarker.position = coords;
        cacheMarker.title = cache.name;
        cacheMarker.snippet = [NSString stringWithFormat:@"By %@", cache.userCreated];
        cacheMarker.appearAnimation = kGMSMarkerAnimationPop;
        cacheMarker.icon = [UIImage imageNamed:@"arrow.png"];
        cacheMarker.map = mapView_;
        NSLog(@"%@", cache.name);
    }
    
    
}

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
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

@end
