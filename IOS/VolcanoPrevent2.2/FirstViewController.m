//
//  FirstViewController.m
//  VolcanoPrevent2.2
//
//  Created by Erick  Alcántar Elías on 20/02/15.
//  Copyright (c) 2015 Erick  Alcántar Elías. All rights reserved.
//

#import "FirstViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface FirstViewController ()

@end

@implementation FirstViewController{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:28.674616 longitude: -106.079891 zoom:17];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.accessibilityElementsHidden = YES;
    mapView_.mapType = kGMSTypeHybrid;
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(28.674372, -106.076389);
    marker.title = @"Plaza TEC";
    marker.snippet = @"Reunion/Evacuation Point";
    marker.icon = [UIImage imageNamed:@"info"];
    marker.map = mapView_;
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    self.view = mapView_;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
}


-(void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:17];
        mapView_.mapType = kGMSTypeHybrid;
        
        GMSMutablePath *path = [GMSMutablePath path];
        [path addCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)];
        [path addCoordinate:CLLocationCoordinate2DMake(@(28.674329).doubleValue,@(-106.078406).doubleValue)];
        [path addCoordinate:CLLocationCoordinate2DMake(@(28.674726).doubleValue,@(-106.076555).doubleValue)];
        [path addCoordinate:CLLocationCoordinate2DMake(@(28.674372).doubleValue,@(-106.076389).doubleValue)];
        
        GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
        rectangle.strokeWidth = 2.f;
        rectangle.map = mapView_;
        
        NSLog(@"Latitud %f", location.coordinate.latitude);
        NSLog(@"Longitude %f", location.coordinate.longitude);
        
        CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(28.677863, -106.066183);
        GMSCircle *redzone = [GMSCircle circleWithPosition:circleCenter
                                                 radius:500];
        GMSCircle *yellowzone = [GMSCircle circleWithPosition:circleCenter
                                                radius:800];

        
        redzone.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];
        redzone.strokeColor = [UIColor redColor];
        redzone.strokeWidth = 5;
        
        yellowzone.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:0.4];
        yellowzone.strokeColor = [UIColor yellowColor];
        yellowzone.strokeWidth = 2;
        
        GMSMarker *alertS = [GMSMarker markerWithPosition:circleCenter];
        alertS.title = @"ALERT!";
        alertS.icon = [UIImage imageNamed:@"warning"];
        alertS.map = mapView_;

        
        
        redzone.map = mapView_;
        yellowzone.map = mapView_;
        
        self.view = mapView_;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
