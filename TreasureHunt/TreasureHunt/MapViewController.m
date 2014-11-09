//
//  MapViewController.m
//  TreasureHunt
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Cyrax. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController () <GMSMapViewDelegate>
@end

@implementation MapViewController{
    GMSMapView *mapView_;
    GMSCameraPosition *camera;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    camera = [GMSCameraPosition cameraWithLatitude:42.7
                                         longitude:23.3333
                                              zoom:15];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(42.7, 23.3333);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    //[super viewDidLoad];
    //GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868 longitude:151.2086 zoom:6];
    //self.view = [GMSMapView mapWithFrame:CGRectZero camera:camera];
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
