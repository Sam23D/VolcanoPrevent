//
//  FirstViewController.h
//  VolcanoPrevent2.2
//
//  Created by Erick  Alcántar Elías on 20/02/15.
//  Copyright (c) 2015 Erick  Alcántar Elías. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController<CLLocationManagerDelegate, GMSMapViewDelegate>{
    
    NSString *latitude;
    NSString *longitude;
    NSString *altitude;
    NSDictionary *res;
    GMSMutablePath *path;
    NSArray *pathline;
    
    
    double latitudD;
    double longitudD;
    
}

@property NSString *toLatitude;
@property NSString *toLongitude;
@property NSString *toAltitude;
@property (nonatomic, retain) CLLocationManager *localizador;
@property (nonatomic, strong) NSMutableData *responseData;

@end

