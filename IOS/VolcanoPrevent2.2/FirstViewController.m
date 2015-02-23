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

@synthesize responseData = _responseData;


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
    
    
    
    // Listen to the myLocation property of GMSMapView.
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    [mapView_ animateToBearing:0];
    
    self.view = mapView_;
    
    
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
    
    
   
    
}

- (void)connection: (NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Did recieve response");
    [self.responseData setLength:0];
}

-(void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data{
    [self.responseData appendData:data];
}


-(void)connection:(NSURLConnection *) connection didFailWithError:(NSError *)error{
    NSLog(@"did fail with error");
    NSLog([NSString stringWithFormat:@"connection fail,%@",[error description]]);
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection{
    NSLog(@"Connection did finish loading");
    NSLog(@"succeded recieve %d bits of data",[self.responseData length]);
    //convert to JSON
    NSError *myerror = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myerror];
    
    //show all values
    for (id key in res) {
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@",keyAsString);
        NSLog(@"value: %@",valueAsString);
        
    }
    
    // stract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@",icon);
    }
    
    path = [GMSMutablePath path];
    
    pathline = [res objectForKey:@"route"];
    
    [path addCoordinate:CLLocationCoordinate2DMake(latitudD,longitudD)];
    
    for(NSString *geopt in pathline){
        NSLog(@"latlon: %@", geopt);
        NSArray *aux = [geopt componentsSeparatedByString:@","];
        double lat = [[aux objectAtIndex:0] doubleValue];
        NSLog([NSString stringWithFormat:@"lat: %f", lat]);
        double lon = [[aux objectAtIndex:1] doubleValue];
        NSLog([NSString stringWithFormat:@"lon: %f", lon]);
        [path addCoordinate:CLLocationCoordinate2DMake(lat,lon)];
        
        
    }
    
    NSLog(@"draw start");
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    NSArray *latlon = [[pathline lastObject] componentsSeparatedByString:@","];
    
    //marker.position = CLLocationCoordinate2DMake(28.674372, -106.076389);
    marker.position = CLLocationCoordinate2DMake([[latlon objectAtIndex:0] doubleValue], [[latlon objectAtIndex:1] doubleValue]);
    
    marker.title = @"Plaza TEC";
    marker.snippet = @"Reunion/Evacuation Point";
    marker.icon = [UIImage imageNamed:@"meetpt"];
    marker.map = mapView_;
    
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.strokeWidth = 2.f;
    rectangle.map = mapView_;
    
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

- (void) DrawPath {
    pathline = [res objectForKey:@"route"];
    

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
        
        NSLog(@"Latitud %f", location.coordinate.latitude);
        NSLog(@"Longitude %f", location.coordinate.longitude);
        
        
        latitudD = location.coordinate.latitude;
        longitudD = location.coordinate.longitude;
        
        self.responseData = [NSMutableData data];
        NSLog(@"request con lat:%f lon:%f",latitudD,longitudD);
        NSString *mylocationurl = [NSString stringWithFormat:@"http://volcanoprevent.appspot.com/evaRoute/%f_%f",latitudD,longitudD];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:mylocationurl]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        mapView_.mapType = kGMSTypeHybrid;
        
        
        
        
       
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
