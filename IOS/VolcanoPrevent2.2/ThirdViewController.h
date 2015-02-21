//
//  ThirdViewController.h
//  VolcanoPrevent2.2
//
//  Created by Erick  Alcántar Elías on 20/02/15.
//  Copyright (c) 2015 Erick  Alcántar Elías. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *news;
    NSMutableArray *icon;
    UIImage *help;
    UIImage *warning;
    UIImage *info;
    
}

@end
