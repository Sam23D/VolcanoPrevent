//
//  FirstViewController.m
//  VolcanoPrevent2.2
//
//  Created by Erick  Alcántar Elías on 20/02/15.
//  Copyright (c) 2015 Erick  Alcántar Elías. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController{
    GMSMapView *mapView_;
    BOOL firstLocationUpdate_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:10.500 longitude:34.556 zoom:8];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.mapType = kGMSTypeSatellite;
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.accessibilityElementsHidden = YES;
    /*
    CGRect f = self.view.frame; //To resize the map view
    CGRect mapFrame = CGRectMake(f.origin.x, 44, f.size.width, f.size.height);
    mapView_ = [GMSMapView mapWithFrame:mapFrame camera:camera];
    //[self.view addSubview:mapView_];*/
    
    self.view = mapView_;
}


-(void)startLocation{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
